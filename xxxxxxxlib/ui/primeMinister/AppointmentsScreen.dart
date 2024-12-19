import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/NewsService.dart';
import 'package:reidsc/core/services/PrimeMinisterService.dart';
import 'package:reidsc/core/services/UserService.dart';

import 'package:reidsc/data/model/primeMinister/Appointment.dart';
import 'package:reidsc/generic/NewsCardWidget.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/NotificationsService.dart';
import '../../data/model/Notifications/Notification.dart';

class AppointmentsScreen extends StatefulWidget {
  // final String selectedTopics;

  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  static const _pageSize = 5;

  final PagingController<int, Appointment> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    // getUserSavedNews();
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final items = await PrimeMinisterService().getAppointments(pageKey);

      final isLastPage = items.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(items);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(items, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, Appointment>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Appointment>(
            itemBuilder: (context, item, index) => InkWell(
              onTap: () {
                /*   Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailsScreen(
                          newD: item,

                        ),
                      ),
                    );*/
              },
              child: Padding(
                padding: EdgeInsets.all(10.0).r,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: 280.w,
                    height: 310.h,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      //crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              DioBaseService().Cap_Upload_URL +
                                  item.photo.toString(),
                              width: 370.w,
                              height: 190.h,
                              fit: BoxFit.cover,
                            ),
                          ), // If it's missing, display an empty box
                          // If it's missing, display an empty box
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0).r,
                          child: Row(children: [
                            Flexible(
                              child: AutoSizeText(
                                item.titleE.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.sp, color: Color(0xff212121)),
                                minFontSize: 15,
                                maxFontSize: 16,
                              ),
                            ),
                            /*IconButton(onPressed: () async {


                                    },
                                        icon:intbookmarks.contains(item.id)?
                                        Icon(Icons.bookmark, color: Color(0xff212121),
                                            size: 25.0):  Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                            size: 25.0))*/
                          ]),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.r),
                          child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  item.formattedAppointmentDate.toString(),
                                  style: TextStyle(color: Colors.black45),
                                  minFontSize: 15,
                                  maxFontSize: 16,
                                ),
                                Icon(
                                  Icons.date_range,
                                  color: Colors.black45,
                                  size: 20.0,
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
