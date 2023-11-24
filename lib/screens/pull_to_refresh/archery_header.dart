import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

const double kTriggerOffset = 200.0;

class ArcheryHeader extends Header {
  const ArcheryHeader({
    super.clamping = false,
    super.triggerOffset = kTriggerOffset,
    super.position = IndicatorPosition.above,
    super.processedDuration = Duration.zero,
    super.springRebound = false,
    super.hapticFeedback = false,
    super.safeArea = false,
    super.spring,
    super.readySpringBuilder,
    super.frictionFactor,
    super.infiniteOffset,
    super.hitOver,
    super.infiniteHitOver,
  });

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return ArcheryIndicator(
      state: state,
      reverse: state.reverse,
    );
  }
}
class ArcheryIndicator extends StatefulWidget {
  const ArcheryIndicator({Key? key, required this.state, required this.reverse,}) : super(key: key);

  final IndicatorState state;
  final bool reverse;

  @override
  State<ArcheryIndicator> createState() => _ArcheryIndicatorState();
}

class _ArcheryIndicatorState extends State<ArcheryIndicator> {
  double get _offset => widget.state.offset;
  IndicatorMode get _mode => widget.state.mode;
  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  /// rive controller and input values
  StateMachineController? controller;
  SMINumber? pull;
  SMITrigger? advance;

  RiveFile? riveFile;

  double kTriggerOffset = 200.0;


  @override
  void initState() {
    loadRiveFile();
    widget.state.notifier.addListener(() {
      onModeChange(_mode, _offset);
    });
    super.initState();
  }

  void onModeChange(IndicatorMode mode, double offset) {
    //print(mode);
    switch (mode) {
      case IndicatorMode.drag:
        controller?.isActive = true;
      case IndicatorMode.ready:
        advance?.change(true);
      case IndicatorMode.processing:
        advance?.change(true);
      default:
        break;
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
    widget.state.notifier.removeListener(() {
      onModeChange(_mode, _offset);
    });
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (_mode == IndicatorMode.drag || _mode == IndicatorMode.armed) {
      final percentage = (_offset / _actualTriggerOffset).clamp(0.0, 1.1) * 100;
      pull?.value = percentage;
    }
    return SizedBox(
            height: _offset,
            width: double.maxFinite,
            child: (_offset > 1 && riveFile != null)?
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
                pull = controller!.findInput<double>('pull') as SMINumber;
                advance = controller!.findInput<bool>('advance') as SMITrigger;
              },
            ): const SizedBox.shrink()
        );
  }
}

