import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyProgress{
  DailyProgress({required this.title});
  final String title;

}

final List<DailyProgress>dP = [
  DailyProgress(title: 'Day 1'),
  DailyProgress(title: 'Day 2'),
  DailyProgress(title: 'Day 3'),
  DailyProgress(title: 'Day 4'),
  DailyProgress(title: 'Day 5'),
  DailyProgress(title: 'Day 6'),
  DailyProgress(title: 'Day 7'),
  DailyProgress(title: 'Day 8'),
];

class DailyProgressCard extends StatelessWidget {
  const DailyProgressCard({
    required this.model,
    super.key,
  });
  
  final DailyProgress model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.title,
                style: const TextStyle(color: Colors.black,
                    fontSize: 25, fontWeight: FontWeight.bold),),
              const Text('finished', style: TextStyle(color: Colors.black26, fontSize: 13),),
            ],
          ),
          SvgPicture.asset('assets/checkmark.svg', width: 30,),
        ],
      ),
    );
  }
}