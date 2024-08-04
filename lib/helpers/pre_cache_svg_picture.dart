import 'package:flutter_svg/svg.dart';

// pre_cache_svg_picture
Future preCacheSvgPicture(String svgPath) async {
  final logo = SvgAssetLoader(svgPath);
  await svg.cache.putIfAbsent(logo.cacheKey(null), () => logo.loadBytes(null));
}