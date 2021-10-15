import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageGallery extends StatefulWidget {
  final String officePhotoUrl;
  ImageGallery(this.officePhotoUrl);
  @override
  _ImageGalleryState createState() => _ImageGalleryState(officePhotoUrl);
}

class _ImageGalleryState extends State<ImageGallery> {
  String officePhotoUrl;
  _ImageGalleryState(this.officePhotoUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: false,
          boundaryMargin: EdgeInsets.all(0),
          minScale: 1,
          maxScale: 5,
          child: Image(
            fit: BoxFit.fitWidth,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            image: CachedNetworkImageProvider(officePhotoUrl),
          ),
        ),
      ),
    );
  }
}
