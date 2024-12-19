import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/data/model/setting/Settings.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({Key? key, required this.settingD})
      : super(key: key);
  final Settings settingD;

  @override
  _GeneralSettingsScreenState createState() => _GeneralSettingsScreenState();
}

const primaryColor = Color(0xFFffffff);
String longtext =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio." +
        "Praesent libero. Sed cursus ante dapibus diam. Sed nisi." +
        "Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum.";

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  // late List<SettingsName> settingslist=[];

  @override
  void initState() {
    // TODO: implement initState
    // loadSources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: AutoSizeText(
          widget.settingD.name.toString(),
          style: TextStyle(fontSize: 17, fontFamily: 'Cairo'),
          minFontSize: 18,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios,
                textDirection: TextDirection.ltr),
            color: Colors.black,
          )
        ],
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Html(data: widget.settingD.description.toString())),
    );
  }
}
