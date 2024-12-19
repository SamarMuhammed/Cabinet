import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/generic/TabBarWidget.dart';
import 'package:reidsc/ui/cabinet/AffiliatedBodiesScreen.dart';
import 'package:reidsc/ui/primeMinister/AppointmentsScreen.dart';
import 'package:reidsc/ui/cabinet/FormerMinistersScreen.dart';
import 'package:reidsc/ui/primeMinister/taskScreen.dart';

class CabinetTabsScreen extends StatefulWidget {
  const CabinetTabsScreen({Key? key}) : super(key: key);

  @override
  _CabinetTabsScreenState createState() => _CabinetTabsScreenState();
}

class _CabinetTabsScreenState extends State<CabinetTabsScreen> {

  late List<IndCategory> categories = [] ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<IndCategory> c ;
    categories.add(new IndCategory(id: 1,name: "Former Prime Ministers",isSelected: true));
    categories.add(new IndCategory(id: 2,name: "Affiliated Bodies",isSelected: false));


  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        appBar: AppBar(
          elevation: 0.0,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Prime Minister",style:GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20.sp))
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [

            //NotificationMenu()
            //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
          ],
          titleTextStyle:  TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              bottom: PreferredSize(
                  preferredSize:  Size.fromHeight(50.h),

                  child:

                  TabBarWidget(tabs: categories,))
              ,
              toolbarHeight: 0,
            ),

            body:
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child:  TabBarView(
                children: [
               FormerMinistersScreen(),
                  AffiliatedBodiesScreen(),

                ],
              ),
            ),

          ),
        ),
      );
  }

}
