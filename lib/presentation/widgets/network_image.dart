import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:movio/presentation/widgets/place_holder.dart';

import 'asset_image.dart';

class NetWorkImageWidget extends StatelessWidget {
  const NetWorkImageWidget(
      {Key? key,
      required this.image,
      this.height = 120,
      this.width = 80,
      this.placeholder,
      this.radius = 15,
      this.fit = BoxFit.fill})
      : super(key: key);

  final double height;
  final double width;
  final String? image;
  final String? placeholder;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: image == null || image!.trim() == ''
          ? placeholder == null
              ? AppPlaceHolder(height: height, width: width, radius: radius)
              : AssetImageView(
                  fileName: placeholder!,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                )
          : CachedNetworkImage(
              imageUrl: "$image",
              width: width,
              height: height,
              fit: fit,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  AppPlaceHolder(height: height, width: width, radius: radius),
              errorWidget: (context, url, error) =>
                  AppPlaceHolder(height: height, width: width, radius: radius),
            ),
    );
  }
}
