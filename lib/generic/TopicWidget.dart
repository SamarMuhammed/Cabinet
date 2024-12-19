
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicWidget extends StatefulWidget {

const TopicWidget({Key? key,required this.title,required this.imageURL,
required this.width,required this.height}) : super(key: key);
final String imageURL;
final String title;
final double width;
final double height;

@override
_TopicWidgetState createState() => _TopicWidgetState();
}

class _TopicWidgetState extends State<TopicWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(26.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color:Colors.transparent,
              offset: Offset(1.0, 1.0),
              blurRadius: 10.0,
            ),
          ],

        ),
        child: Column(
          children: <Widget>[


            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),

                    child: Image.network(widget.imageURL,
                      fit: BoxFit.cover,
                      height: widget.height, width: widget.width,))


            ),


             SizedBox(height: 2.h),
            Material(color: Colors.transparent,
                child: Center(child: AutoSizeText(widget.title, style:GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 14.sp)),minFontSize: 14,maxFontSize: 16,))),


          ],


        ),


      );
  }
}