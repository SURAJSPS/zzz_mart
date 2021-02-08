import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeTabBannerShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Shimmer.fromColors(
      child: new Stack(
        children: [
          Container(
            height: size.width * 0.4,
            width: size.width,
            color: colorScheme.onSurface,
          ),
        ],
      ),
      baseColor: Colors.grey[100],
      highlightColor: Colors.white.withOpacity(0.5),
      enabled: true,
    );
  }
}
