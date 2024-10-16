import 'package:flutter/material.dart';
import 'package:rive_flutter/f_demo/samples/asset_load_sample.dart';
import 'package:rive_flutter/f_demo/samples/events_sample.dart';
import 'package:rive_flutter/f_demo/samples/statemachine_sample.dart';
import 'package:rive_flutter/f_demo/samples/text_run_sample.dart';
import 'package:rive_flutter/widgets/options.dart';

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutterbytes Demo",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(children: [
        ...items.map((e) {
          return Options(
              title: e,
              onTap: () {
                switch (e) {
                  case 'Events Sample':
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventsSample()));
                    break;
                  case 'Text Run Sample':
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TextRunSample()));
                    break;
                  case 'Asset Load Sample':
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AssetSwapSample()));
                    break;
                  case 'State machine Sample':
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StatemachineSample()));
                    break;
                }
              });
        })
      ]),
    );
  }
}

final List<String> items = [
  'Events Sample',
  'Text Run Sample',
  'Asset Load Sample',
  'State machine Sample'
];
