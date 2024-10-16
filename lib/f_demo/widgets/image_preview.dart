import 'package:flutter/material.dart';
import 'package:rive_flutter/f_demo/samples/asset_load_sample.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.asset,
    required this.onTap,
  });

  final String asset;
  final OnImageTap onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(asset),
      child: Container(
        height: 150,
        width: 250,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }
}
