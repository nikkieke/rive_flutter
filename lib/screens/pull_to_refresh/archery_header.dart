import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rive/rive.dart';

class ArcheryHeader extends StatefulWidget {
  const ArcheryHeader({Key? key, required this.refreshController}) : super(key: key);
  final RefreshController refreshController;

  @override
  State<ArcheryHeader> createState() => _ArcheryHeaderState();
}

class _ArcheryHeaderState extends State<ArcheryHeader> {
  /// rive controller and input values
  StateMachineController? controller;

  SMIInput<double>? pull;
  SMIInput<bool>? advance;

  RiveFile? riveFile;

  double kTriggerOffset = 200.0;

  double kOffset = 0;

  @override
  void initState() {
    loadRiveFile();
    widget.refreshController.headerMode?.addListener(() {
      if(widget.refreshController.headerStatus == RefreshStatus.canRefresh){
        controller?.isActive = true;
      } else if (widget.refreshController.headerStatus == RefreshStatus.refreshing) {
        advance?.change(true);
      } else if (widget.refreshController.headerStatus == RefreshStatus.completed) {
        advance?.change(true);
      }
    });
    super.initState();
  }

  void onModeChange (RefreshStatus mode)async{
    print('here2');
    if(widget.refreshController.headerStatus == RefreshStatus.canRefresh){
      controller?.isActive = true;
    } else if (widget.refreshController.headerStatus == RefreshStatus.refreshing) {
      advance?.change(true);
    } else if (widget.refreshController.headerStatus == RefreshStatus.completed) {
      advance?.change(true);
    }
  }

  void loadRiveFile(){
    rootBundle.load('assets/rive_assets/pullToRefresh.riv').then((data) async {
      setState(() {
        riveFile = RiveFile.import(data);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    widget.refreshController.headerMode?.removeListener(() => onModeChange);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      completeDuration: const Duration(seconds: 1),
      height: kTriggerOffset,
      refreshStyle: RefreshStyle.Behind,
      onOffsetChange: (offset) {
        if (widget.refreshController.headerMode?.value != RefreshStatus.refreshing){
          kOffset = offset;
          final percentage = (offset / kTriggerOffset).clamp(0.0, 1.1) * 100;
          pull?.value = percentage;
        }
      },
      builder: (BuildContext context, RefreshStatus? mode) {
        return SizedBox(
            height: kOffset,
            width: double.maxFinite,
            child: (kOffset > 1 && riveFile != null)?
            RiveAnimation.direct(
              riveFile!,
              fit: BoxFit.cover,
              stateMachines: const ["numberSimulation"],
              artboard: 'Bullseye',
              onInit: (artboard) {
                controller = StateMachineController.fromArtboard(
                  artboard,
                  "numberSimulation",
                );
                controller?.isActive = false;
                if (controller == null) return;
                artboard.addController(controller!);
                pull = controller?.findInput("pull");
                advance = controller?.findInput("advance");
              },
            ): const SizedBox.shrink()
        );
      },
    );
  }
}

