import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/HierarchyService.dart';
import 'package:reidsc/data/model/Hierarchy/Minister.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/ui/hierarchy/ministerDetailsScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class allMinistersScreen extends StatefulWidget {
  const allMinistersScreen({Key? key}) : super(key: key);

  @override
  _allMinistersScreenState createState() => _allMinistersScreenState();
}

class _allMinistersScreenState extends State<allMinistersScreen> {
  late List<Minister> ministersList = [];
  int page = 1;
  String currentLanguage = 'en';

  final PagingController<int, Minister> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _loadLanguage();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }
  void _loadLanguage() async {
    currentLanguage = await getSelectedLanguage();
    print("loadlang$currentLanguage");
    setState(() {}); // Update UI with the selected language
  }

  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage') ?? 'en'; // Default to English
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      final items = await HierarchyService().getMinisters(pageKey);
      //  print(pageKey);
      //  print(newItems.length);
      //  print(newItems[0].title);

      final isLastPage = items.length < 10;
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
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'home_ministry'.tr(),
          style: GoogleFonts.tajawal(
              textStyle: TextStyle(
            fontSize: 20.sp,
          )),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          //NotificationMenu()
          //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
        ],
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 22.sp, fontWeight: FontWeight.bold),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, Minister>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Minister>(
            itemBuilder: (context, item, index) => InkWell(
              onTap: () {
                getMinisterByID(item.id).then((value) => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MinisterDetails(minister: value!),
                        ),
                      )
                    });
              },
              child: Padding(
                padding: EdgeInsets.all(10.0).r,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: 280.w,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height / 6
                        : MediaQuery.of(context).size.height / 5,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 80.0,
                                      height: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.height /
                                              8
                                          : MediaQuery.of(context).size.height /
                                              5,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          child: Image.network(
                                            DioBaseService().Cap_Upload_URL +
                                                item.photo.toString(),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: SizedBox(
                                              width: 250,
                                              //  width: 150,
                                              child: AutoSizeText(
                                                LocalizationHelper.getLocalizedValue(item.toMap(), currentLanguage, 'name'),
                                                //   overflow: TextOverflow.ellipsis,
                                                //        textDirection: TextDirection.rtl,

                                                style: (TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Color(0xffb5102b),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                                minFontSize: 15,
                                                maxFontSize: 16,
                                              ),
                                            ),
                                          ),

                                          /*  Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: (){print("On Click icon");},
                                            child: Container(

                                                child: Icon(
                                                  Icons.bookmark_border_outlined,
                                                  color: Colors.black87,
                                                  size: 23,
                                                ),
                                            ),
                                          ),
                                        ),*/
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: SizedBox(
                                              width: 250,
                                              child: AutoSizeText(
                                                LocalizationHelper.getLocalizedValue(item.toMap(), currentLanguage, 'ministryName'),
                                                maxLines: 2,

                                                overflow: TextOverflow.ellipsis,
                                                //        textDirection: TextDirection.rtl,

                                                style: (TextStyle(
                                                    fontSize: 14.sp)),
                                                minFontSize: 14,
                                                maxFontSize: 16,
                                              ),
                                            ),
                                          ),

                                          /*  Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: (){print("On Click icon");},
                                            child: Container(

                                                child: Icon(
                                                  Icons.bookmark_border_outlined,
                                                  color: Colors.black87,
                                                  size: 23,
                                                ),
                                            ),
                                          ),
                                        ),*/
                                        ],
                                      ),
                                      /*   Row(

                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:8.0),
                                                      child:SizedBox(
                                                        width: 250,
                                                        child: AutoSizeText(
                                                        "Since March 2019"  ,maxLines: 2,

                                                          overflow: TextOverflow.ellipsis,
                                                          //        textDirection: TextDirection.rtl,

                                                          style: (TextStyle(fontSize: 16.sp)),
                                                          minFontSize: 15,maxFontSize: 16,
                                                        ),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                                Row(

                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top:8.0),
                                                      child:SizedBox(
                                                        width: 150,
                                                        child: AutoSizeText(
                                                         'Date Of Birth '+ ministersList[index].ministryNameE.toString(),maxLines: 2,

                                                          overflow: TextOverflow.ellipsis,
                                                          //        textDirection: TextDirection.rtl,

                                                          style: (TextStyle(fontSize: 16.sp)),
                                                          minFontSize: 15,maxFontSize: 16,
                                                        ),
                                                      ),
                                                    ),

                                                    /*  Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: (){print("On Click icon");},
                                            child: Container(

                                                child: Icon(
                                                  Icons.bookmark_border_outlined,
                                                  color: Colors.black87,
                                                  size: 23,
                                                ),
                                            ),
                                          ),
                                        ),*/
                                                  ],
                                                ),*/
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ));

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
