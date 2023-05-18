import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/api_constants.dart';

class AppCachedImage extends StatelessWidget {
  final String url;
  final double? height, width;
  final BoxShape shape;
  final BoxFit? fit;
  const AppCachedImage({
    Key? key,
    this.height,
    required this.url,
    this.width,
    this.shape = BoxShape.rectangle,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${ApiConstants.baseUrl}/$url",
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            shape: shape,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        );
      },
      errorWidget: (context, url, error) {
        debugPrint(error.toString());
        return const Center(
          child: Icon(Icons.error),
        );
      },
    );
  }
}
