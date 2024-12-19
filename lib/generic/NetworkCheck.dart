import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
bool _allow = true;

class NetworkCheckScreen extends StatefulWidget {
  const NetworkCheckScreen({Key? key}) : super(key: key);

  @override
  _NetworkCheckScreenState createState() => _NetworkCheckScreenState();
}

class _NetworkCheckScreenState extends State<NetworkCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return  new WillPopScope(
      onWillPop: () async => false,

      child:  new Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("No Internet Connection... Please connect to the internet ",style: TextStyle(
                fontSize: 22
            ),)),
SizedBox(height:20),
            Center(
              child: ElevatedButton(
                style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Color(0xffb5102b))),
                child: Text('OK', style: TextStyle(fontSize: 20.0,),),

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
      ),
    );
  }
}