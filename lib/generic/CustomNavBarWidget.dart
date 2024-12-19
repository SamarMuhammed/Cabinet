import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem>
      items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Color(0xff0D005F)),
      height: 60.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff8F3F71) : const Color(0xff0D005F),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: IconTheme(
                data: IconThemeData(
                    size: 30.0,
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary ?? item.activeColorPrimary),
                child: item.icon,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0.r),
              child: Material(
                type: MaterialType.transparency,
                child: FittedBox(
                    child: Text(
                  item.title.toString(),
                  style: TextStyle(
                      color: isSelected
                          ? (item.activeColorSecondary ??
                              item.activeColorPrimary)
                          : item.inactiveColorPrimary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0.sp),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 60.0.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
