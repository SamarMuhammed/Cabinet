import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/services/CabinetService.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/Cabinet/FormerMinister.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/ui/media/MediaDetailsScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FormerMinistersScreen extends StatefulWidget {
  const FormerMinistersScreen({Key? key}) : super(key: key);

  @override
  State<FormerMinistersScreen> createState() => _FormerMinistersScreenState();
}

class _FormerMinistersScreenState extends State<FormerMinistersScreen> {

  static const _pageSize = 10;

  final PagingController<int, FormerMinister> _pagingController =
  PagingController(firstPageKey: 1);


  @override
  void initState() {
    // TODO: implement initState


    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);

    });


    super.initState();
  }


  Future<void> _fetchPage(int pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final items = await CabinetService().getFormerMinistries(pageKey);

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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
            onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
            ),
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PagedGridView<int, FormerMinister>(
                //  itemCount: mediaList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio:2 / 3,
                    crossAxisCount: 2,
                  ),
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<FormerMinister>(

                      itemBuilder: (context, item, index) => Padding(
                          padding: EdgeInsets.all(5.r),
                          child: Card(

                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Container(

                                        decoration: BoxDecoration(
                                          color:  Color(0xff052444),
                                          image: DecorationImage(
                                              image: NetworkImage( DioBaseService().Cap_Upload_URL+item.photoE.toString()),
                                              fit: BoxFit.fill),
                                        ),
                                      )
                                  )

                                ],
                              )))
                  )

              ),
            )
        )
    );


  }
}
