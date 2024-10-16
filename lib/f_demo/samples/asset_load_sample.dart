import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:rive_flutter/f_demo/widgets/image_preview.dart';

class AssetSwapSample extends StatefulWidget {
  const AssetSwapSample({super.key});

  @override
  State<AssetSwapSample> createState() => _AssetSwapSampleState();
}

class _AssetSwapSampleState extends State<AssetSwapSample> {
  String? imageAsset;

  void setImage(String asset) {
    setState(() {
      imageAsset = asset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            RiveCard(
              imageAsset: imageAsset,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              //width: double.infinity,
              // height: double.maxFinite,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images
                        .map((e) => ImagePreview(asset: e, onTap: setImage))
                        .toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RiveCard extends StatefulWidget {
  const RiveCard({this.imageAsset, super.key});

  final String? imageAsset;

  @override
  State<RiveCard> createState() => _RiveCardState();
}

class _RiveCardState extends State<RiveCard> {
  late RiveFile file;
  bool loading = true;
  ImageAsset? imageAssetReference;

  @override
  void initState() {
    super.initState();
    loadRiveFile();
  }

  Future<void> swapImage() async {
    if (widget.imageAsset == null) return;

    late Uint8List newImageData;
    newImageData =
        (await rootBundle.load(widget.imageAsset!)).buffer.asUint8List();

    final image = await ImageAsset.parseBytes(newImageData);
    imageAssetReference?.image = image;
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    if (oldWidget.imageAsset != widget.imageAsset) {
      swapImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> loadRiveFile() async {
    file = await RiveFile.asset(
      'assets/rive_assets/holo_card.riv',
      assetLoader: CallbackAssetLoader(
        (asset, embeddedBytes) async {
          if (asset is ImageAsset) {
            // store a reference to update later
            imageAssetReference = asset;
          }
          // load the default embedded asset
          return false;
        },
      ),
    );
    loading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const SizedBox.shrink();

    return Container(
      color: Colors.black,
      height: 300,
      width: 300,
      child: RiveAnimation.direct(
        file,
        stateMachines: const ['cardInteractivity'],
      ),
    );
  }
}

final List<String> images = [
  'assets/bg2.jpg',
  'assets/bg5.jpg',
  'assets/bg6.jpg',
];

typedef OnImageTap = void Function(String asset);
