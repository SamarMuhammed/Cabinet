import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:reidsc/ui/Home.dart';
import 'package:reidsc/ui/settings/SettingsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reidsc/generic/PresistantTabBar.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final Function(String selectedLanguage) onLanguageSelected;
  const LanguageSelectionScreen({Key? key, required this.onLanguageSelected})
      : super(key: key);
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en-US', 'abbreviation': 'E', 'flag': 'assets/images/uk.png', 'topic': 'Cabinet'},
    {'name': 'French', 'code': 'fr', 'abbreviation': 'F', 'flag': 'assets/images/france.png', 'topic': 'cabinetfr'},
    {'name': 'Spanish', 'code': 'es', 'abbreviation': 'Es', 'flag': 'assets/images/spain.png', 'topic': 'cabinetes'},
    {'name': 'Russian', 'code': 'ru', 'abbreviation': 'R', 'flag': 'assets/images/russia.png', 'topic': 'cabinetru'},
    {'name': 'Chinese', 'code': 'C', 'abbreviation': 'C', 'flag': 'assets/images/china.png', 'topic': 'cabinetzh'},
    {'name': 'Italian', 'code': 'It', 'abbreviation': 'It', 'flag': 'assets/images/italy.png', 'topic': 'cabinetit'},
  ];

  String? selectedLanguageCode;
   bool? isFirstLaunch;

  @override
  void initState() {
    super.initState();
    checkLanguage();
    _loadSelectedLanguage();
   // _onLanguageSelected();
  }

  var check;
  checkLanguage() async {
     check = await prefs.getBool('isFirstLaunch');
    print("The check contidion $check");
  }

  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguageCode = prefs.getString('selectedLanguage') ?? 'en-US'; // Default to English
    });
  }
  void _onLanguageSelected() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);

    // Navigate to Home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NavBarHome()),
    );
  }


  Future<void> _setSelectedLanguage(String languageCode, String topic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    await prefs.setString('selectedLanguage', languageCode);
    await prefs.setBool('isFirstLaunch',false);
    var check = await prefs.getBool('isFirstLaunch');
   // print("The check contidion $check");
    setState(() {
      selectedLanguageCode = languageCode;
    });
    for (var language in languages) {
      if (language['topic'] != topic) {
        await FirebaseMessaging.instance.unsubscribeFromTopic(language['topic']!);
        print('Unsubscribed from ${language['topic']}');
      }
    }
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    // Subscribe to the specific Firebase topic
    FirebaseMessaging.instance.subscribeToTopic(topic);

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Subscribed to notifications for $languageCode'),
      ),
    );
  }


  // Map custom codes to valid Locale objects
  Locale getLocaleFromCustomCode(String code) {
    switch (code) {
      case 'en-US':
        return Locale('en', 'US');
      case 'fr':
        return Locale('fr');
      case 'es':
        return Locale('es');
      case 'ru':
        return Locale('ru');
      case 'C': // Custom code for Chinese
        return Locale('zh', 'CN');
      case 'It': // Custom code for Italian
        return Locale('it', 'IT');
      default:
        return Locale('en', 'US'); // Fallback to English
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffb5102b),
        title: Text('Select Language'),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = selectedLanguageCode == language['code'];

          return GestureDetector(
            onTap: () {
    _setSelectedLanguage(language['code']!, language['topic']!);

    // Map the custom code to a valid Locale
    Locale locale = getLocaleFromCustomCode(language['code']!);
    context.setLocale(locale);
    if(check == false) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen(),),
      );
    }
    else{

      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NavBarHome()),
    );
    // Respond to button press

    }
            },
            child: Container(
              color: isSelected ? Colors.grey[300] : Colors.transparent, // Highlight if selected
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                children: [
                  // Circular flag image
                  CircleAvatar(
                    radius: 20, // Adjust size
                    backgroundImage: AssetImage(language['flag']!),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      language['name']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.black : Colors.grey[800],
                      ),
                    ),
                  ),
                  Text(
                    language['abbreviation']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
