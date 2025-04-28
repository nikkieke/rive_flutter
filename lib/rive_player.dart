import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive_native/rive_native.dart' as rive;

/// This is an example high-level implementation widget using the Rive Native Painters.
class RivePlayer extends StatefulWidget {
  const RivePlayer({
    super.key,
    required this.asset,
    this.stateMachineName,
    this.artboardName,
    this.hitTestBehavior = rive.RiveHitTestBehavior.opaque,
    this.cursor = MouseCursor.defer,
    this.fit = rive.Fit.contain,
    this.alignment = Alignment.center,
    this.layoutScaleFactor = 1.0,
    this.withArtboard,
    this.withStateMachine,
    this.withViewModelInstance,
    this.assetLoader,
    this.autoBind = true,
  });
  final String asset;
  final String? stateMachineName;
  final String? artboardName;
  final rive.RiveHitTestBehavior hitTestBehavior;
  final MouseCursor cursor;
  final rive.Fit fit;
  final Alignment alignment;
  final double layoutScaleFactor;
  final rive.AssetLoaderCallback? assetLoader;
  final bool autoBind;

  final void Function(rive.StateMachine stateMachine)? withStateMachine;
  final void Function(rive.Artboard artboard)? withArtboard;
  final void Function(rive.ViewModelInstance viewModelInstance)?
      withViewModelInstance;

  @override
  State<RivePlayer> createState() => _RivePlayerState();
}

class _RivePlayerState extends State<RivePlayer> {
  rive.File? riveFile;

  late rive.Artboard artboard;
  late rive.StateMachinePainter stateMachinePainter;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    riveFile = await _loadFile();
    if (riveFile == null) return;

    if (widget.artboardName != null) {
      artboard = riveFile!.artboard(widget.artboardName!)!;
    } else {
      artboard = riveFile!.artboardAt(0)!;
    }
    widget.withArtboard?.call(artboard);

    stateMachinePainter = rive.RivePainter.stateMachine(
      stateMachineName: widget.stateMachineName,
      withStateMachine: (stateMachine) {
        widget.withStateMachine?.call(stateMachine);
        if (!widget.autoBind) return;
        final vm = riveFile!.defaultArtboardViewModel(artboard);
        if (vm == null) {
          return;
        }
        final vmi = vm.createDefaultInstance();
        if (vmi == null) {
          return;
        }
        stateMachine.bindViewModelInstance(vmi);
        widget.withViewModelInstance?.call(vmi);
      },
    )
      ..hitTestBehavior = widget.hitTestBehavior
      ..cursor = widget.cursor
      ..fit = widget.fit
      ..alignment = widget.alignment
      ..layoutScaleFactor = widget.layoutScaleFactor;

    setState(() {});
  }

  Future<rive.File?> _loadFile() async {
    final bytes = await rootBundle.load(widget.asset);
    return rive.File.decode(
      bytes.buffer.asUint8List(),
      riveFactory: RiveExampleApp.getCurrentFactory,
      assetLoader: widget.assetLoader,
    );
  }

  @override
  void didUpdateWidget(RivePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hitTestBehavior != oldWidget.hitTestBehavior) {
      stateMachinePainter.hitTestBehavior = widget.hitTestBehavior;
    }
    if (widget.cursor != oldWidget.cursor) {
      stateMachinePainter.cursor = widget.cursor;
    }
    if (widget.fit != oldWidget.fit) {
      stateMachinePainter.fit = widget.fit;
    }
    if (widget.alignment != oldWidget.alignment) {
      stateMachinePainter.alignment = widget.alignment;
    }
    if (widget.layoutScaleFactor != oldWidget.layoutScaleFactor) {
      stateMachinePainter.layoutScaleFactor = widget.layoutScaleFactor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return riveFile != null
        ? rive.RiveArtboardWidget(
            artboard: artboard,
            painter: stateMachinePainter,
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    artboard.dispose();
    riveFile?.dispose();
    super.dispose();
  }
}

class RiveExampleApp {
  static bool isRiveRender = true;

  static rive.Factory get getCurrentFactory =>
      isRiveRender ? rive.Factory.rive : rive.Factory.flutter;
}
