import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/SettingService.dart';
import 'package:reidsc/core/services/SourcesService.dart';
import 'package:reidsc/data/model/setting/Source.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'SwitchButtonWidget.dart';
class SourcesScreen extends StatefulWidget {
  const SourcesScreen({Key? key}) : super(key: key);

  @override
  _SourcesScreenState createState() => _SourcesScreenState();
}

const primaryColor = Color(0xFFffffff);
String longtext =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio." +
        "Praesent libero. Sed cursus ante dapibus diam. Sed nisi." +
        "Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum.";

class _SourcesScreenState extends State<SourcesScreen> {
  late List<Sources> sourceslist = [];

  loadSources() async {
    sourceslist = await SourcesService().getSource();
    print(sourceslist[0].name);
    print(sourceslist[0].name);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadSources();
    super.initState();
  }

  final List dummyList = List.generate(1000, (index) {
    return {
      "id": index,
      "title": "This is the title $index",
      "subtitle": "This is the subtitle $index"
    };
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        appBar: AppBar(
          elevation: 0.0,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            "Sources",
            style: GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20)),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,

          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_forward_ios,
                  textDirection: TextDirection.ltr),
              color: Colors.black,
            )
          ],
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        body: ListView.builder(
          itemCount: sourceslist.length,
          itemBuilder: (context, index) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 6,
            margin: EdgeInsets.all(10),
            child: ListTile(

                // title: Text('TEXT HERE: ${dummyList[index]["title"]}'),

                //subtitle: Text('TEXT HERE: ${dummyList[index]["title"]}'),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Source: ',
                          style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                  fontSize: width * 0.045,
                                  color: Color(0xff8F3F71)))),
                      TextSpan(
                          text: sourceslist[index].name.toString(),
                          style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                  fontSize: width * 0.045, color: Colors.blue)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              var url = sourceslist[index].link.toString();
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            })
                    ],
                  ),
                ),
                subtitle: RichText(
                    // textAlign: TextAlign.center,
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Email: ',
                      style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                              fontSize: width * 0.045,
                              color: Color(0xff8F3F71)))),
                  TextSpan(
                      text: sourceslist[index].email.toString(),
                      style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                              fontSize: width * 0.045, color: Colors.black)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final Uri params = Uri(
                              scheme: 'mailto',
                              path: sourceslist[index].toString(),
                              queryParameters: {
                                /*  'subject': '',
                                    'body': ' ',*/
                                'mailto': sourceslist[index].email.toString(),
                              });
                          var url = params.toString();
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                ]))
                //trailing: Icon(Icons.add_a_photo),
                ),
          ),
        ));
  }
}
