import 'package:flutter/material.dart';
import 'package:muski_bday/utils/navigation.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  final String imageUrl;
  PhotoViewScreen({
    this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            child: PhotoView(
              imageProvider: NetworkImage(imageUrl),
              loadingBuilder: (context, url) => Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                NavigationUtils.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
