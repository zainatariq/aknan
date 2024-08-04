import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewBody extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  const PageViewBody({
    super.key,
    required this.image,
    required this.subTitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Image(
              height: 300.h,
              width: 300.w,
              image: AssetImage(image),
              // image: AssetImage(image),
              // key: Key('${Random().nextInt(999999999)}'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
          // CustomImage(
          //   image: image,
          //   height: 86,
          //   width: 86,
          //   placeholder: Assets.imagesPngsPlaceholder,
          // ),
          // K.sizedBoxH1,
          const SizedBox(height: 30),
          Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          // K.sizedBoxH3,
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subTitle,
              // style: K.hintLargeTextStyle,
              // textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
