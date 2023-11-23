import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rive/rive.dart';
import 'package:rive_flutter/screens/pull_to_refresh/rive_header.dart';

class PullToRefreshScreen extends StatefulWidget {
  const PullToRefreshScreen({Key? key}) : super(key: key);

  @override
  State<PullToRefreshScreen> createState() => _PullToRefreshScreenState();
}

class _PullToRefreshScreenState extends State<PullToRefreshScreen> {
  final RefreshController refreshController = RefreshController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        header: const RiveHeader(),
        onRefresh: () async {
          await Future.delayed(
              const Duration(seconds: 5),(){
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


