import '../helpers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoPage extends StatefulWidget {
  final Widget? child;
  final List<String> netImages;

  const PhotoPage({
    super.key,
    this.child,
    this.netImages = const [],
  });

  factory PhotoPage.networkImage(String url) {
    return PhotoPage(
      child: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(url),
          ),
          PositionedDirectional(
            top: 50,
            end: 20,
            child: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: CircleAvatar(
                    radius: 12,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 17.sp,
                      ),
                    ),
                  ));
            }),
          )
        ],
      ),
    );
  }

  factory PhotoPage.assetsPng(String path) {
    return PhotoPage(
      child: PhotoView(
        imageProvider: AssetImage(path),
      ),
    );
  }

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  bool get isGalaryView => widget.netImages.isNotEmpty;

  PageController? pageController;
  int? _currentIndex;
  @override
  void initState() {
    if (isGalaryView) {
      pageController = PageController();
      _currentIndex = 0;
    }
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isGalaryView
          ? PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                var item = widget.netImages[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(item),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(tag: item),
                );
              },
              itemCount: widget.netImages.length,
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                      // value: event == null
                      //     ? 0.0
                      //     : num.tryParse((event.cumulativeBytesLoaded / event.expectedTotalBytes?.toInt()).toString())?.toDouble(),
                      ),
                ),
              ),
              pageController: pageController,
              onPageChanged: onPageChanged,
            )
          : widget.child,
    );
  }
}
