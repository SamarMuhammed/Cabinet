import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarWidget extends StatefulWidget {
  final List<dynamic> tabs;

  const TabBarWidget({
    Key? key,
    required this.tabs,
    Color? indicatorColor,
    BoxDecoration? indicator,
    Color? labelColor,
    Color? unselectedLabelColor,
    TextStyle? labelStyle,
  }) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  var selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(this.tabs);
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: const Color(0xff0D005F),
      indicator: const BoxDecoration(
        color: Color(0xffb5102b),
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      labelStyle: GoogleFonts.tajawal(
        fontSize: 14.sp,
        // fontFamily: GoogleFonts.tajawal().fontFamily.toString(),
        fontWeight: FontWeight.bold,
      ),
      tabs: [
        for (final tab in widget.tabs)
          Tab(
            text: tab.name,
          )
      ],
    );
  }
}
