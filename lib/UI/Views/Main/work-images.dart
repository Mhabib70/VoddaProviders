import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/api-urls.dart';

class WorkImages extends StatelessWidget {
  var galleryItems;
  WorkImages(this.galleryItems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              (kIsWeb ? baseImageUrl : AppController.baseUrl) +
                  galleryItems[index],
            ),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: index),
          );
        },
        itemCount: galleryItems.length,
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded /
                        event.expectedTotalBytes!.toInt(),
            ),
          ),
        ),
        // backgroundDecoration: backgroundDecoration,
        // pageController: pageController,
        onPageChanged: (index) {},
      ),
    );
  }
}
