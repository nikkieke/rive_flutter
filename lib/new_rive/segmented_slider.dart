import 'package:flutter/material.dart';
import 'package:rive_flutter/rive_player.dart';
import 'package:rive_native/rive_native.dart' as rive;

class SegmentedSlider extends StatefulWidget {
  const SegmentedSlider({super.key});

  @override
  State<SegmentedSlider> createState() => _SegmentedSliderState();
}

class _SegmentedSliderState extends State<SegmentedSlider> {
  late rive.StateMachine stateMachine;
  late rive.ViewModelInstance viewModelInstance;
  late rive.ViewModelInstanceNumber selectedIndex;
  late rive.NumberInput currentIndex;
  late rive.NumberInput nextIndex;
  late rive.NumberInput selected;

  @override
  void dispose() {
    selectedIndex.removeListener(_onIndexChange);
    selectedIndex.dispose();
    viewModelInstance.dispose();
    super.dispose();
  }

  void _onIndexChange(double value) {
    print('selected index $value');
    if (value != nextIndex.value) {
      currentIndex.value = nextIndex.value;
    }
    nextIndex.value = value;
    print('next ${nextIndex.value}');
    print('current ${currentIndex.value}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        child: Container(
          height: 250,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: RivePlayer(
            asset: "assets/rive_assets/segmented_slider.riv",
            artboardName: "Artboard",
            fit: rive.Fit.contain,
            stateMachineName: "State Machine 1",
            autoBind: true,
            withStateMachine: (sm) {
              stateMachine = sm;
              nextIndex = sm.number("next")!;
              currentIndex = sm.number("current")!;
              selected = sm.number("selected")!;

              currentIndex.value = 2;
              nextIndex.value = 2;

              print('selected index ${selected.value}');
              if (selected.value != nextIndex.value) {
                currentIndex.value = nextIndex.value;
              }
              nextIndex.value = selected.value;
              print('next ${nextIndex.value}');
              print('current ${currentIndex.value}');
            },
            withViewModelInstance: (viewModelInstance) {
              this.viewModelInstance = viewModelInstance;
              print(viewModelInstance.properties);

              selectedIndex = viewModelInstance.number('index')!;

              selectedIndex.addListener(_onIndexChange);
              selectedIndex.value = 2;
            },
          ),
        ),
      ),
    );
  }
}
