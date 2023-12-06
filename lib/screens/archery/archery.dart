import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'archery_header.dart';
import 'daily_progress_card.dart';


class ArcheryScreen extends StatefulWidget {
  const ArcheryScreen({Key? key}) : super(key: key);

  @override
  State<ArcheryScreen> createState() => _ArcheryScreenState();
}

class _ArcheryScreenState extends State<ArcheryScreen> {
  final RefreshController refreshController = RefreshController();
  int number = 8;

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  void incrementItem(){
    setState(() {
      number++;
      dP.add(DailyProgress(title: 'Day ${number.toString()}'));
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          header: ArcheryHeader(refreshController: refreshController),
          onRefresh: () async {
            await Future.delayed(
                const Duration(seconds: 2),(){
            });
            incrementItem();

            if (!mounted) {
              return;
            }
            refreshController.refreshCompleted();
          },
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Fitness Targets'),
                pinned: true,
              ),
              SliverList(delegate:
              SliverChildBuilderDelegate(
                  (context, index){
                    final reversedDp = dP.reversed.toList();
                    final dailyProgress = reversedDp[index];
                    return DailyProgressCard(model: dailyProgress,);
                  },
                  childCount: dP.length,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}




