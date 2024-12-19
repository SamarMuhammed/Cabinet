import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/generic/TabBarWidget.dart';
import 'package:reidsc/ui/PoliciesAndInformations/GovAgenda.dart';
import 'package:reidsc/ui/PoliciesAndInformations/GovAnnualReport.dart';
import 'package:reidsc/ui/PoliciesAndInformations/OwnerShipDocument.dart';
import 'package:reidsc/ui/PoliciesAndInformations/Vision2030.dart';
import 'package:reidsc/ui/primeMinister/AppointmentsScreen.dart';
import 'package:reidsc/ui/primeMinister/biographyScreen.dart';
import 'package:reidsc/ui/primeMinister/taskScreen.dart';

class PoliciesTabsScreen extends StatefulWidget {
  const PoliciesTabsScreen({Key? key}) : super(key: key);

  @override
  _PoliciesTabsScreenState createState() => _PoliciesTabsScreenState();
}

class _PoliciesTabsScreenState extends State<PoliciesTabsScreen> {
  late List<IndCategory> categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<IndCategory> c;
    categories.add(
        new IndCategory(id: 1, name: 'policies_vision'.tr(), isSelected: true));
    categories.add(new IndCategory(
        id: 2, name: 'policies_state'.tr(), isSelected: false));
    categories.add(new IndCategory(
        id: 3, name: 'policies_Government'.tr(), isSelected: false));
    categories.add(new IndCategory(
        id: 4, name: 'policies_annual'.tr(), isSelected: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('home_policies'.tr(),
            style: GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20.sp))),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          //NotificationMenu()
          //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
        ],
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 22.sp, fontWeight: FontWeight.bold),
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: TabBarWidget(
                  tabs: categories,
                )),
            toolbarHeight: 0,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                Vision2030Screen(),
                OwnerShipDocumentScreen(),
                GovAgendaScreen(),
                GovAnnualReportScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
