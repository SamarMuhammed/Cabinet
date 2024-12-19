import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:reidsc/ui/settings/SettingsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchWidget extends StatefulWidget {
  final bool switchControl;
  const SwitchWidget({Key? key, required this.switchControl}) : super(key: key);

  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass();
}

class SwitchWidgetClass extends State {
  var textHolder = 'Switch is OFF';
  late SharedPreferences prefs;

  Future<void> toggleSwitch(bool value) async {
    prefs = await SharedPreferences.getInstance();
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        prefs.setBool("notification", switchControl);
        // textHolder = 'Switch is ON';
        FirebaseMessaging.instance.subscribeToTopic('IDSC');
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.
    } else {
      setState(() {
        switchControl = false;
        prefs.setBool("notification", switchControl);
        // textHolder = 'Switch is OFF';
        FirebaseMessaging.instance.unsubscribeFromTopic('IDSC2040');
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.5,
          child: Switch(
            onChanged: toggleSwitch,
            value: switchControl,
            activeColor: Color(0xff8f3f71),
            activeTrackColor: Color(0xffc199b2),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          )),

      // Text('$textHolder', style: TextStyle(fontSize: 24),)
    ]);
  }
}
