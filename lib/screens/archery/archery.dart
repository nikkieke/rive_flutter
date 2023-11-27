import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'archery_header.dart';


class ArcheryScreen extends StatefulWidget {
  const ArcheryScreen({Key? key}) : super(key: key);

  @override
  State<ArcheryScreen> createState() => _ArcheryScreenState();
}

class _ArcheryScreenState extends State<ArcheryScreen> {
  final RefreshController refreshController = RefreshController();

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        header: ArcheryHeader(refreshController: refreshController),
        onRefresh: () async {
          await Future.delayed(
              const Duration(seconds: 2),(){
          });
          if (!mounted) {
            return;
          }
          refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Shooting practice'),
              pinned: true,
            ),
            SliverList(delegate: SliverChildListDelegate(buildList()))
          ],
        ),
      ),
    );
  }

  List<Widget> buildList() {
    return List.generate(
        13,
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


