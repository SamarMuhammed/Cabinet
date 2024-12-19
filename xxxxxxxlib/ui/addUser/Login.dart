import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/user/User.dart';
import 'package:reidsc/data/model/user/UserAge.dart';
import 'package:reidsc/data/model/user/UserGender.dart';
import 'package:reidsc/data/model/user/UserJob.dart';
import 'package:reidsc/main.dart';
import 'package:reidsc/ui/intro/TopicsScreen.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {


  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerFullName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerJob = TextEditingController();
  TextEditingController controllerGender = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  List<UserJob> UserJobList = [];
  var UserJobLoaded = false;

  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // declare a variable to keep track of the input text
  String _name = '';
  String _email = '';
  bool nameValid = false;
  bool emailValid = false;

  var message;

  loadUserJob() async {
    UserJobList = await UserService().getUserJob();

    setState(() {
      UserJobLoaded = true;
      selectedJob = UserJobList[0];
    });
  }

  String? selectedValue;

  // final _formKey = GlobalKey<FormState>();
  late List<UserAge> UserAgeList = [];
  var UserAgeLoaded = false;

  loadUserAge() async {
    UserAgeList = await UserService().getUserAge();
    setState(() {
      UserAgeLoaded = true;
      _selectedAge = UserAgeList[0].id!;
    });
  }

  late List<UserGender> UserGenderList =[];
  var UserGenderLoaded = false;
  late int _selectedGender ;
  late int _selectedAge ;
  late int _selectedJob ;

  String? get _errorNameText {
    var text;
    // at any time, we can get the text from _controller.value.text
    setState(() {
      text = controllerFullName.value.text;

      // Note: you can do your own custom validation here
      // Move this logic this outside the widget for more testable code

    });
    if (text.isEmpty) {
      return 'من فضلك قم بإدخال الاسم';
    }
    if (text.length > 25) {
      return 'الحد الأفصي لعدد الحروف 25';
    }
    // return null if the text is valid
    return null;
  }

  loadUserGender() async {
    UserGenderList = await UserService().getUserGender();
    setState(() {
      UserGenderLoaded = true;
      _selectedGender =  UserGenderList[0].id!;
    });
  }
  void checkUserID ()  async
  {

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserID();
    loadUserJob();
    loadUserAge();
    loadUserGender();
  }

  UserJob? selectedJob;


  //late int _user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Form(
          key: _formKey,
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.only(top: 10.0.r),
                  child: Center(
                    child: Container(
                        width: 180.w,
                        height: 150.h,
                        /*decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50.0)),*/
                        child: CircleAvatar(radius:40,
                          backgroundImage: AssetImage('assets/images/logo.png'),
                        )),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 24).r,
                      child: Text(
                        "Name",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.sp),

                      ),

                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                      left: 24.0, right: 23.0, top: 5, bottom: 0).r,
                  //padding: EdgeInsets.symmetric(horizontal: 15),

                  child: TextFormField(
                    maxLength: 25,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (text) => setState(() => _name = text),
                    //controller:controllerFullName ,
                    textAlign: TextAlign.left,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        nameValid = false;
                        return 'Name is required';
                      }
                      if (text.length < 10) {
                        nameValid = false;
                        return 'Name must be more than 10 characters ';
                      }
                      if (text.length > 25) {
                        return 'Name must not exceed 25 characters';
                      }
                      nameValid = true;
                      return null;
                    },
                    decoration: InputDecoration(
                      // errorText:  _submitted  ? _errorNameText : null,
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(12).r,
                      enabledBorder:  OutlineInputBorder(
                        borderSide:  BorderSide(color: Color(0xff21212133),
                            width: 3.0.w),

                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: Color(0xff21212133),
                            width: 4.0.w),
                        borderRadius: BorderRadius.circular(5.0.r),

                      ),

                      //hintText: 'Enter valid email id as abc@gmail.com'
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 24).r,
                      child: Text(
                        "Email",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                      left: 24.0, right: 23.0, top: 10, bottom: 0).r,
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    // controller: controllerEmail,
                    textAlign: TextAlign.left,
                    onChanged: (text) => setState(() => _email = text),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (text == null || text.isEmpty) {
                        emailValid = false;
                        return 'Email is required';
                      }
                      if (!regex.hasMatch(text)) {
                        emailValid = false;
                        return 'Please enter valid email';
                      }
                      emailValid = true;
                      return null;
                    },
                    //obscureText: true,
                    decoration: InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(12.r),
                      enabledBorder:  OutlineInputBorder(
                        borderSide:  BorderSide(color: Color(0xff21212133),
                            width: 3.0.w),


                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: Color(0xff21212133),
                            width: 4.0.w),
                        borderRadius: BorderRadius.circular(5.0.r),

                      ),
                    ),
                  ),
                ),

                //  FlatButton(
                //  onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
                //  },
                // child: Text(
                //   'Forgot Password',
                //   style: TextStyle(color: Colors.blue, fontSize: 15),
                //  ),
                //  ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 24,top: 10).r,
                      child: Text(
                        "Job",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 10, left: 24, top: 10).r,
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal: 12.0.r),
                      height: 60.0.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.0),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InputDecorator(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                //labelText: 'Label',
                                enabledBorder: OutlineInputBorder
                                  (borderRadius: BorderRadius.circular(3.0.r),
                                  borderSide: BorderSide(
                                      color: Color(0xff21212133), width: 3.0.w),
                                ),

                              ),
                              child: DropdownButtonHideUnderline(

                                child: DropdownButton<UserJob>(

                                  borderRadius: BorderRadius.circular(12.0.r),
                                  value: selectedJob,
                                  // icon: const Icon(Icons.arrow_drop_down),
                                  //iconSize: 24,
                                  //   hint: Text("أختر الوظيفة"),

                                  elevation: 8,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15.sp),
                                  onChanged: (UserJob? newValue) {
                                    setState(() {
                                      selectedJob = newValue!;
                                    });
                                  },
                                  items: UserJobList.map((UserJob List) {
                                    return DropdownMenuItem<UserJob>(
                                      child: Text(List.name!,
                                          style: TextStyle(
                                              color: Colors.black)),
                                      value: List,

                                    );
                                  }).toList(),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                SizedBox(
                  height: 5.h,

                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 24.r,top: 5.r),
                      child: Text(
                        "Gender",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 30.r),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // WAY 1

                        children: UserGenderList
                            .map((data) =>
                            Flexible(
                              child: RadioListTile(
                                dense: true,
                                activeColor: Colors.blue,
                                contentPadding: EdgeInsets.zero,
                                // controlAffinity: ListTileControlAffinity.trailing,

                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "${data.name}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                  ],

                                ),

                                groupValue: _selectedGender,
                                value: data.id!,
                                onChanged: (val) {
                                  setState(() {
                                    print('Val: ' + val.toString());
                                    _selectedGender = data.id!;
                                  });
                                },

                              ),
                            ))
                            .toList(),

                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 1.h,

                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 24.r),
                      child: Text(
                        "Age",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.0.h,
                        child: Padding(
                          padding:  EdgeInsets.only(right: 24, left: 30).r,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // WAY 1

                            children: UserAgeList
                                .map((data) =>
                                Flexible(
                                  child: RadioListTile(
                                    dense: true,
                                    activeColor: Colors.blue,
                                    contentPadding: EdgeInsets.zero,
                                    // controlAffinity: ListTileControlAffinity.trailing,

                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "${data.name}",
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 15.sp),
                                        ),

                                      ],
                                    ),
                                    groupValue: _selectedAge,
                                    value: data.id!,
                                    onChanged: (val) {
                                      setState(() {
                                        print('Val: ' + val.toString());
                                        _selectedAge = data.id!;
                                      });
                                    },

                                  ),
                                ))
                                .toList(),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding:  EdgeInsets.all(18.0.r),
                  child: Container(
                    height: 50.h,
                    width: 510.w,
                    decoration: BoxDecoration(
                      //color: Color(0xff0D005F), borderRadius: BorderRadius.circular(10)

                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff0D005F)
                      ),
                      onPressed: nameValid && emailValid
                          ? _onSaveUSer
                          : null,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //  height: 10,
                //   ),
                // Text('New User? Create Account')
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _submitted = false;

  void _showDialog(BuildContext context, message, status) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          //title: new Text("Alert!!"),
          content: new Text(message),
          actions: status ?<Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>TopicsScreen(previousPage: "Login",)));

              },
            ),
          ]:null,
        );
      },
    );
  }

  showRes(bool status, String message,int content) async {
    final SharedPreferences prefs = await _prefs;
    print("userID "+content.toString());
    if(status) {
      prefs.setInt('UserID', content);
      print(prefs.getInt('UserID'));
      _showDialog(context, message, status);

    }
    else {
      prefs.setInt('UserID', 0);
      if(content == -1)
        _showDialog(context, "هذا البريد الإلكتروني مُستخدم من قبل", status);
else
      _showDialog(context, "حدث خطأ ... يُُرجى إعادة المحاولة", status);
    }
  }

  void _onSaveUSer() async {
    //TextEditingController controllerFullName= TextEditingController();
    //TextEditingController controllerEmail=TextEditingController();
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      // notify the parent widget via the onSubmit callback
      //  widget.onSubmit(controllerFullName.value.text);
      var deviceId = await PlatformDeviceId.getDeviceId;

      User u = User(genderID: _selectedGender,
          ageID: _selectedAge,
          jobID: selectedJob?.id,
          name: _name,
          email: _email,
          deviceId: deviceId);
      print(u.toJson());

      await UserService().addUser(u).then((res) =>
      {
        // print(res.data)
        showRes(res.data["status"], res.data["message"],res.data["content"])
      }
      );
    }
  }
}






