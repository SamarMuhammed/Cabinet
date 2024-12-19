import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/SettingService.dart';
import 'package:reidsc/data/model/setting/Settings.dart';
import 'package:reidsc/ui/LanguageSelectionScreen.dart';
import 'package:reidsc/ui/settings/AboutScreen.dart';
import 'package:reidsc/ui/settings/GeneralSettingsScreen.dart';
import 'package:reidsc/ui/settings/SourcesScreen.dart';
import 'package:reidsc/ui/settings/SwitchbuttonWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

bool _switchValue = true;
const primaryColor = Color(0xFFffffff);
late bool switchControl;

late SharedPreferences prefs;
String? _version;
String? _buildNumber;
String? _buildSignature;
String? _appName;
String? _packageName;
String? _installerStore;

class _SettingsScreenState extends State<SettingsScreen> {
  late List<Settings> settingslist = [];
  String currentLanguage = 'en';

  void _loadLanguage() async {
    currentLanguage = await getSelectedLanguage();
    print("loadlang$currentLanguage");
    setState(() {}); // Update UI with the selected language
  }

  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage') ?? 'en'; // Default to English
  }
  Future<void> loadSources() async {
    // Fetch settings from API
    settingslist = await SettingsService().getAppSettings();

    // Add the static "Language" item to the list
print(settingslist[0]);

    setState(() {});
  }

  @override
  void initState() {
    _loadLanguage();
    loadSources();
    getPref();
    _getAppVersion();
    super.initState();
  }

  void _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
      _buildSignature = packageInfo.buildSignature;
      _appName = packageInfo.appName;
      _packageName = packageInfo.packageName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'nav_settings'.tr(),
          style: GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 18)),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: settingslist.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    if (settingslist[index].eName == "Language") {
                      // Navigate to the SelectLanguageScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) =>  LanguageSelectionScreen(onLanguageSelected: (String selectedLanguage) {  },),
                        ),
                      );
                    } else if (settingslist[index].type != "Radio" &&
                        settingslist[index].eName != "Sources" &&
                        settingslist[index].eName != "Contact Us") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => GeneralSettingsScreen(
                            settingD: settingslist[index],
                          ),
                        ),
                      );
                    } else if (settingslist[index].eName == "Sources") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => SourcesScreen(),
                        ),
                      );
                    } else if (settingslist[index].eName == "Contact Us") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => AboutScreen(),
                        ),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      if (settingslist[index].type != "Radio")
                        Padding(
                          padding: const EdgeInsets.only(left: 33, top: 20),
                          child: AutoSizeText(
                            LocalizationHelper.getLocalizedValue(settingslist[index].toMap(), currentLanguage, 'name'),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.tajawal().fontFamily,
                              fontSize: 10,
                            ),
                            minFontSize: 16,
                            maxFontSize: 24,
                          ),
                        )
                      else
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 33),
                              child: AutoSizeText(
                                LocalizationHelper.getLocalizedValue(settingslist[index].toMap(), currentLanguage, 'name'),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily:
                                  GoogleFonts.tajawal().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                                minFontSize: 18,
                                maxFontSize: 24,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 140),
                              child: SwitchWidget(
                                switchControl: switchControl,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'version_no'.tr()  +'${_version ?? '-'}',
                  style: TextStyle(
                    color: Color(0xffb5102b),
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.tajawal().fontFamily,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      switchControl = prefs.getBool("notification") ?? true;
    });
  }
}
