import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/data/model/setting/Settings.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({Key? key, required this.settingD})
      : super(key: key);
  final Settings settingD;

  @override
  _GeneralSettingsScreenState createState() => _GeneralSettingsScreenState();
}

const primaryColor = Color(0xFFffffff);
String currentLanguage = 'en';



Future<String> getSelectedLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('selectedLanguage') ?? 'en'; // Default to English
}

void _loadLanguage() async {
  currentLanguage = await getSelectedLanguage();
  print("loadlang$currentLanguage");
  //setState(() {}); // Update UI with the selected language
}
late String versionNo;
String longtext =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio." +
        "Praesent libero. Sed cursus ante dapibus diam. Sed nisi." +
        "Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum.";

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  // late List<SettingsName> settingslist=[];
  void getVersionNo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionNo = packageInfo.version;
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadLanguage();
    // loadSources();
    getVersionNo();
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
            LocalizationHelper.getLocalizedValue(widget.settingD.toMap(), currentLanguage, 'name')     ,
          style: GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 17)),
          minFontSize: 18,
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
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Html(data:LocalizationHelper.getLocalizedValue(widget.settingD.toMap(), currentLanguage, 'description'),
                )),
          ),
        ],
      ),
    );
  }
}
