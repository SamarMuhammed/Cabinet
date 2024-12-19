
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();

}
const primaryColor = Color(0xFFffffff);

class _AboutScreenState extends State<AboutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('settings_about'.tr(),style:GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20)),),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        actions: [


          IconButton(onPressed: (){
            Navigator.of(context).pop();

          },
            icon: const Icon(Icons.arrow_forward_ios,textDirection:ui.TextDirection.ltr),color: Colors.black,)
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),
      ),
      body:          Padding(
        padding: const EdgeInsets.only(top:50),
        child: Container(
          //  color: Colors.red,
          height: 250,
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              // color: Colors.white70,

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right:30,left:30,top:15),
                        child: Text(


                          'contact_screen'.tr(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
               /*     Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right:50,left:50,top:10),
                        child: Text(
                          'ص ب : 191 مجلس الشعب - رقم بريدي : 11582',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),*/
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right:65,left:65,top:10),
                        child: Text(
                          '+20227935000',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          RichText(
                            // textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  // text: 'info@idsc.net.eg  ',
                                  style: TextStyle(
                                      color:Color(0xff8F3F71),fontSize: 15
                                  ),
                                ),
                                TextSpan(
                                    text:'contact_complaint'.tr(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:Color(0xff8F3F71),
                                      // decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url = "https://www.shakwa.eg/GCP/Default.aspx";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'contact_url'.tr() +url;
                                        }
                                      }),

                              ])),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );


  }
}