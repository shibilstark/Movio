import 'package:flutter/material.dart';
import 'package:movio/config/paths.dart';
import 'package:movio/presentation/widgets/network_image.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';

class MoviePosterWidget extends StatelessWidget {
  const MoviePosterWidget({
    super.key,
    required this.height,
    required this.width,
    required this.poster,
  });

  final double height;
  final double width;
  final String? poster;

  @override
  Widget build(BuildContext context) {
    return RoundedContainerWidget(
      borderRadius: BorderRadius.circular(5),
      key: UniqueKey(),
      height: height,
      width: width,
      child: NetWorkImageWidget(image: ApiPaths.image(poster)),
    );
  }
}
