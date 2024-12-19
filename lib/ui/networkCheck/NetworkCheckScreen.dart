import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetworkCheckScreen extends StatefulWidget {
  const NetworkCheckScreen({Key? key}) : super(key: key);

  @override
  _NetworkCheckScreenState createState() => _NetworkCheckScreenState();
}

class _NetworkCheckScreenState extends State<NetworkCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("!برجاء التحقق من الاتصال بالشبكة ثم المعاودة لاحقا",style: TextStyle(
              fontSize: 22
          ),)),

          Center(
            child: ElevatedButton(
              child: Text('تأكيد', style: TextStyle(fontSize: 20.0),),

              onPressed: () {
                if(Platform.isAndroid)
                  SystemNavigator.pop();
                else if(Platform.isIOS)

                  exit(0);
              },
            ),
          ),

        ],
      ),
    );
  }
}