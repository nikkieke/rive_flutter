import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rive/rive.dart';

class PullToRefreshScreen extends StatefulWidget {
  const PullToRefreshScreen({Key? key}) : super(key: key);

  @override
  State<PullToRefreshScreen> createState() => _PullToRefreshScreenState();
}

class _PullToRefreshScreenState extends State<PullToRefreshScreen> {
  final RefreshController refreshController = RefreshController();

  /// rive controller and input values
  StateMachineController? controller;

  SMIInput<double>? pull;
  SMIInput<bool>? advance;

  final double scrollValue = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        // header: SliverToBoxAdapter(
        //     child: SizedBox(
        //       height: pull?.value == 0.0? 0: scrollValue,
        //       child: RiveAnimation.asset('assets/rive_assets/pullToRefresh.riv',
        //         fit: BoxFit.cover,
        //         stateMachines: const ["numberSimulation"],
        //         onInit: (artboard) {
        //           controller = StateMachineController.fromArtboard(
        //             artboard,
        //             "numberSimulation",
        //           );
        //           if (controller == null) return;
        //           artboard.addController(controller!);
        //           pull = controller?.findInput("pull");
        //           advance = controller?.findInput("advance");
        //         },
        //       ),
        //     ),
        //
        // ),
        onRefresh: () async {
          await Future.delayed(
              const Duration(seconds: 2),(){
          });
          refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          slivers: [
            SliverList(delegate: SliverChildListDelegate(buildList()))
          ],
        ),
      ),
    );
  }

  List<Widget> buildList() {
    return List.generate(
        15,
            (index) => Container(
          height: 100,
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
        ));
  }
}


