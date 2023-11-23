import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rive/rive.dart';


class RiveHeader extends RefreshIndicator  {
   const RiveHeader({super.key}) : super(height: 200, refreshStyle: RefreshStyle.Behind);

  @override
  State<RiveHeader> createState() => _RiveHeaderState();
}

class _RiveHeaderState extends State<RiveHeader> {
  /// rive controller and input values
  StateMachineController? controller;

  SMIInput<double>? pull;
  SMIInput<bool>? advance;

   double scrollValue = 0;

  void onModeChange(RefreshStatus mode) {
    if (mode == RefreshStatus.canRefresh) {
      //pull?.change(100);

      for (var i = 0; i < 200; i++) {
        scrollValue++;
        pull?.value = scrollValue;
      }

    }
    if (mode == RefreshStatus.refreshing) {
      advance?.change(true);

    }
    if (mode == RefreshStatus.completed) {
      advance?.change(true);

    }
    onModeChange(mode);
  }

  Future<void> endRefresh() async {
    advance?.change(true);
  }

  void resetValue() {
    pull?.value = 0;
    scrollValue = 0;
    resetValue();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        //height: 200,
        height: pull?.value ==0? 0:scrollValue,
        child: RiveAnimation.asset('assets/rive_assets/pullToRefresh.riv',
          fit: BoxFit.cover,
          stateMachines: const ["numberSimulation"],
          onInit: (artboard) {
            controller = StateMachineController.fromArtboard(
              artboard,
              "numberSimulation",
            );
            if (controller == null) return;
            artboard.addController(controller!);
            pull = controller?.findInput("pull");
            advance = controller?.findInput("advance");
          },
        ),
      ),

    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

