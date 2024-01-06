import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'archery_header.dart';
import 'daily_progress_card.dart';


class ArcheryScreen extends StatefulWidget {
  const ArcheryScreen({Key? key}) : super(key: key);

  @override
  State<ArcheryScreen> createState() => _ArcheryScreenState();
}

class _ArcheryScreenState extends State<ArcheryScreen> {
  late EasyRefreshController controller;
  int number = 8;

  @override
  void initState() {
    controller = EasyRefreshController(
      controlFinishRefresh: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
        child: EasyRefresh(
          controller: controller,
          header: const ArcheryHeader(
            position: IndicatorPosition.locator,
            processedDuration: Duration(seconds: 1),
          ),
          onRefresh: () async {
            await Future.delayed(
                const Duration(seconds: 2),(){
            });
            incrementItem();

            if (!mounted) {
              return;
            }
            controller.finishRefresh();
          },
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Fitness Targets'),
                pinned: true,
              ),
              const HeaderLocator.sliver(),
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




