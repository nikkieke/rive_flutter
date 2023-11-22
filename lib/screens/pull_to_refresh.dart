import 'package:flutter/material.dart';

class PullToRefreshScreen extends StatelessWidget {
  const PullToRefreshScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate(buildList()))
        ],
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
