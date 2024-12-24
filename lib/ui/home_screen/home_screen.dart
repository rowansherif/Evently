import 'package:events_app/ui/home_screen/taps/home/home_tap.dart';
import 'package:events_app/ui/home_screen/taps/love/love_tap.dart';
import 'package:events_app/ui/home_screen/taps/map/map_tap.dart';
import 'package:events_app/ui/home_screen/taps/profile/profile_tap.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:events_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List <Widget> taps = [
    HomeTap(),
    MapTap(),
    LoveTap(),
    ProfileTap()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.transparentColor
        ),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          //notchMargin: 4,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {

                });
              },
              items: [
                buildBottomNavigationBarItem(
                    index: 0,
                    label: AppLocalizations.of(context)!.home,
                    iconSelectedName: AssetsManager.homeIconSelected,
                    iconName: AssetsManager.homeIconUnselected),
                buildBottomNavigationBarItem(
                    index: 1,
                    label: AppLocalizations.of(context)!.map,
                    iconSelectedName: AssetsManager.mapIconSelected,
                    iconName: AssetsManager.mapIconUnselected),
                buildBottomNavigationBarItem(
                    index: 2,
                    label: AppLocalizations.of(context)!.love,
                    iconSelectedName: AssetsManager.favouriteIconSelected,
                    iconName: AssetsManager.favouriteIconUnselected),
                buildBottomNavigationBarItem(
                    index: 3,
                    label: AppLocalizations.of(context)!.profile,
                    iconSelectedName: AssetsManager.profileIconSelected,
                    iconName: AssetsManager.profileIconUnselected),
              ]),
        ),
        
        
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            //TODO: Navigate to add event screen
          },
        child: Icon(Icons.add,
        color:  AppColors.whiteColor,
        size: 35,),

          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: taps[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      {required String label,
      required String iconName,
      required int index,
      required String iconSelectedName}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(selectedIndex == index ? iconSelectedName : iconName)),
        label: label);
  }
}
