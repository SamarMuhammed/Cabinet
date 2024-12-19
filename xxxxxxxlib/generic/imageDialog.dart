

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialog extends StatefulWidget {
  const ImageDialog({Key? key, required this.imageURL}) : super(key: key);
  final String imageURL;

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return  Dialog(

        backgroundColor: Colors.transparent,
        elevation: 0,
        child:
        Container(
          decoration: BoxDecoration
            (
            color: Colors.transparent,

          ),


          height: MediaQuery.of(context).size.height/2.2,
          width: MediaQuery.of(context).size.width ,
          child: PhotoView(
              backgroundDecoration: BoxDecoration(
                  color: Colors.transparent
              ) ,
              initialScale: PhotoViewComputedScale.contained * 1.5,

              maxScale: PhotoViewComputedScale.contained * 8,
              imageProvider:

              NetworkImage( widget.imageURL,


              )),
        )

    );
  }
}