import 'package:flutter/material.dart';
import 'package:reidsc/core/services/HierarchyService.dart';
import 'package:reidsc/core/services/LatestNewsService.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/NewsService.dart';

import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/data/model/Hierarchy/Minister.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/data/model/news/NewsVM.dart';
import 'package:reidsc/generic/NetworkCheck.dart';
import 'package:reidsc/main.dart';
import 'package:reidsc/ui/Reports/ReportsDetailsScreen.dart';
import 'package:reidsc/ui/interIndicators/categoriesScreen.dart';
import 'package:reidsc/ui/localIndicators/chartScreen.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';
import 'package:reidsc/ui/prices/globalPricesDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/TopicService.dart';

Future<NewsVM> getNewsByID(id) async {
  var news = await NewsService().getNewsByID(id: id);
  return news!;
}

Future<Reports> getReportByID(id) async {
  var report = await ReportsService().getReportByID(id);
  return report!;
}

Future<Minister?> getMinisterByID(id) async {
  return await HierarchyService().getMinisterID(id);
}

Future<Media> getMediaByID(id) async {
  var media = await MediaService().getMediaByID(id);
  return media!;
}

gotoNews(NewsVM value) {
  //print("zeft1 " +value.id.toString());
  // print("zeft2 "+userID.toString());

  navigatorKey.currentState?.push(MaterialPageRoute(
    builder: (context) => DetailsScreen(
      newD: value,
    ),
  ));
}

gotoReports(Reports value, userID) {
  //print("zeft1 " +value.id.toString());
  // print("zeft2 "+userID.toString());

  navigatorKey.currentState?.push(MaterialPageRoute(
    builder: (context) => ReportsDetailsScreen(
      ReportsD: value,
      userID: userID,
    ),
  ));
}

gotoIndicators(subCatID, subCatName) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(
        builder: (context) =>
            ChartView(subCatID: subCatID, subCatName: subCatName)),
  );
}

getUserTopics() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
  print("userIdHome " + userID.toString());
  return await TopicService().getSavedTopics(userID);
}

gotoInterIndicators(subCatIndex) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(
        builder: (context) => InterCategoriesScreen(
            index: subCatIndex, selectedTopics: getUserTopics())),
  );
}

gotoPrices(subCatID, subCatName, unit, dailyPrice, yearlyPrice) {
  navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => globalPricesDetailsScreen(
            subCatID: subCatID,
            dailyPrice: dailyPrice,
            yearlyPrice: yearlyPrice,
            unit: unit,
            name: subCatName,
            //   newD: item,
            // userID:this.userID,
          )));
}

gotoNetworkCheck() {
  //print("zeft1 " +value.id.toString());
  // print("zeft2 "+userID.toString());

  navigatorKey.currentState?.push(MaterialPageRoute(
    builder: (context) => NetworkCheckScreen(),
  ));
}
