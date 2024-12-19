import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/CabinetService.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/HierarchyService.dart';
import 'package:reidsc/data/model/Cabinet/Stackholder.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AffiliatedBodiesScreen extends StatefulWidget {
  const AffiliatedBodiesScreen({Key? key}) : super(key: key);

  @override
  _AffiliatedBodiesScreenState createState() => _AffiliatedBodiesScreenState();
}

class _AffiliatedBodiesScreenState extends State<AffiliatedBodiesScreen> {
  late List<Stackholder> StakeholdersList = [];
  String currentLanguage = 'en';

  int page = 1;

  final PagingController<int, Stackholder> _pagingController =
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
      final items = await CabinetService().getStakeholders(pageKey);

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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          //       height: 500,
          child: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
            ),
            child: PagedListView<int, Stackholder>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Stackholder>(
                itemBuilder: (context, item, index) => Padding(
                  padding: EdgeInsets.all(10.0).r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
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
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? MediaQuery.of(context).size.height / 5
                                        : MediaQuery.of(context).size.height /
                                            5,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(17),
                                        child: Image.network(
                                          DioBaseService().Cap_Upload_URL +
                                              item.photo.toString(),
                                          fit: BoxFit.fitWidth,
                                        )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.6,
                                            child: AutoSizeText(
                                              LocalizationHelper.getLocalizedValue(item.toMap(), currentLanguage, 'name'),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textDirection: TextDirection.rtl,
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp)),
                                              minFontSize: 16,
                                              maxFontSize: 18,
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
                                        Expanded(
                                            flex: 2,
                                            child: Icon(
                                              Icons.phone,
                                              color: Color(0xffb5102b),
                                            )),
                                        Expanded(
                                          flex: 12,
                                          child: Text(
                                            item.phone.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    if (item.fax != null)
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Icon(
                                                Icons.fax,
                                                color: Color(0xffb5102b),
                                              )),
                                          Expanded(
                                            flex: 12,
                                            child: Text(
                                              item.fax.toString(),

                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
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
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
