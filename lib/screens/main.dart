import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/cart.dart';
import 'package:active_ecommerce_flutter/screens/category_list.dart';
import 'package:active_ecommerce_flutter/screens/home.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Main extends StatefulWidget {
  Main({Key key, go_back = true}) : super(key: key);

  bool go_back;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  var _children = [
    Home(),
    CategoryList(
      is_base_category: true,
    ),
    Home(),
    Cart(has_bottomnav: true),
    Profile()
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  void initState() {
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          extendBody: true,
          body: _children[_currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //specify the location of the FAB
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom ==
                0.0, // if the kyeboard is open then hide, else show
            child: FloatingActionButton(
              backgroundColor: MyTheme.white,
              onPressed: () {},
              tooltip: "start FAB",
              child: Container(
                  margin: EdgeInsets.all(0.2),
                  child: IconButton(
                      icon: new Image.asset('assets/square_logo.png'),
                      tooltip: 'Action',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Filter(
                            selected_filter: "sellers",
                          );
                        }));
                      })),
              elevation: 0.0,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: onTapped,
                currentIndex: _currentIndex,
                backgroundColor: Colors.white.withOpacity(0.8),
                fixedColor: Theme.of(context).accentColor,
                unselectedItemColor: Color.fromRGBO(153, 153, 153, 1),
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/home.png",
                        color: _currentIndex == 0
                            ? MyTheme.black
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .main_screen_bottom_navigation_home,
                          style: TextStyle(fontSize: 12),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/categories.png",
                        color: _currentIndex == 1
                            ? MyTheme.black
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .main_screen_bottom_navigation_categories,
                          style: TextStyle(fontSize: 12),
                        ),
                      )),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.circle,
                      color: Colors.transparent,
                    ),
                    title: Text(""),
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/cart.png",
                        color: _currentIndex == 3
                            ? MyTheme.black
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .main_screen_bottom_navigation_cart,
                          style: TextStyle(fontSize: 12),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/profile.png",
                        color: _currentIndex == 4
                            ? MyTheme.black
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .main_screen_bottom_navigation_profile,
                          style: TextStyle(fontSize: 12),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
