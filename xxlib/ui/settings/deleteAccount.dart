import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/UserService.dart';
import '../addUser/Login.dart';

class deleteAccountScreen extends StatefulWidget {
  const deleteAccountScreen({Key? key}) : super(key: key);

  @override
  _deleteAccountScreenState createState() => _deleteAccountScreenState();
}

class _deleteAccountScreenState extends State<deleteAccountScreen> {
  String _email = '';
  bool emailValid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("حذف حساب",style:TextStyle(fontSize: 17,fontFamily: 'Cairo'),),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        actions: [


          IconButton(onPressed: (){
            Navigator.of(context).pop();

          },
            icon: const Icon(Icons.arrow_back_ios,textDirection: TextDirection.ltr),color: Colors.black,)
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),
      ),
      body:

      Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column
              (
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                      "إذا أردت حذف الحساب برجاء إدخال البريد الإلكتروني ثم الضغط علي حذف و سوف يتم حذف الحساب نهائياً",
                      style:TextStyle( fontSize: 18,color:Colors.red,fontFamily: 'Cairo' )
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    // controller: controllerEmail,
                    textAlign: TextAlign.right,
                    onChanged: (text) => setState(() => _email = text),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      var regex = RegExp(
                          r"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                      if (text == null || text.isEmpty) {
                        emailValid = false;
                        return 'من فضلك قم بإدخال البريد الالكتروني';
                      }
                      if (!regex.hasMatch(text.replaceAll(' ', ''))) {
                        emailValid = false;
                        return 'من فضلك قم بإدخال البريد الإلكتروني بطريقة صحيحة';
                      }
                      emailValid = true;
                      //
                      // return null;
                    },
                    //obscureText: true,
                    decoration: InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(12.r),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff21212133),
                            width: 3.0.w),


                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff21212133),
                            width: 4.0.w),
                        borderRadius: BorderRadius.circular(5.0.r),

                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff0D005F)
                    ),
                    onPressed: ()=>
                    {
                      if(emailValid)
                        _deleteAccount()
                    },
                    child: Text(
                      'حذف',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, message , content) {
    print("MSG "+message);
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          //title: new Text("Alert!!"),
          content: new Text(message),
          actions:  <Widget>[
            new ElevatedButton(
              child: new Text("OK"),
              onPressed: () {
                if(content == true)
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (builder) => Login()));
                else
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (builder) => deleteAccountScreen()));
              },
            ),
          ] ,
        );
      },
    );
  }

  showRes(bool status, String message, bool content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print ("Dooooooooooone");
    if(content == true)
      prefs.clear();
    _showDialog(context, message, content);
  }

  _deleteAccount() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userID = prefs.getInt("UserID");
      print("UserID " + userID.toString());
      await UserService().deleteUser(userId: userID!, email: _email.replaceAll(' ', '')).then((
          res) =>
      {
//print("sssssss"+res.data["content"].toString())
        showRes(res.data["status"], res.data["message"], res.data["content"])
      });
    }
  }
}
