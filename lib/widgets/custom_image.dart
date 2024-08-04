import '../global/app-assets/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// TODO: add click on img link
class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double radius;
  final String placeholder;
  final String? svg;
  const CustomImage({
    super.key,  this.image, this.height, this.width, this.fit = BoxFit.cover,
    this.placeholder = Assets.imagesPngsPlaceholder, this.radius = 0,  this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return svg != null ? SvgPicture.asset(
      svg!, height: height, width: width, fit: fit,
    ):  ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: image!, height: height, width: width, fit: fit,
        placeholder: (context, url) => Image.asset(Assets.imagesPngsPlaceholder, height: height, width: width, fit: fit),
        errorWidget: (context, url, error) => Image.asset(placeholder, height: height, width: width, fit: fit),
      ),
    );
  }
}
