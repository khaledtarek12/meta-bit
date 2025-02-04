// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:MetaBit/helpers/shared_value_helper.dart';
import 'package:MetaBit/main.dart';
import 'package:MetaBit/my_theme.dart';
import 'package:MetaBit/presenter/bottom_appbar_index.dart';
import 'package:MetaBit/presenter/cart_counter.dart';
import 'package:MetaBit/screens/auth/login.dart';
import 'package:MetaBit/screens/category_list_n_product/category_products.dart';
import 'package:MetaBit/screens/home.dart';
import 'package:MetaBit/screens/profile.dart';
import 'package:MetaBit/screens/swap/swap_screen.dart';
import 'package:MetaBit/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class Main extends StatefulWidget {
  Main({Key? key, go_back = true}) : super(key: key);
  late bool go_back;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  var _children = [];
  CartCounter counter = CartCounter();
  BottomAppbarIndex bottomAppbarIndex = BottomAppbarIndex();

  fetchAll() {
    getCartCount();
  }

  void onTapped(int i) {
    fetchAll();

    if (guest_checkout_status.$ && (i == 2)) {
    } else if (!guest_checkout_status.$ && (i == 2) && !is_logged_in.$) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      return;
    }

    if (i == 3) {
      routes.push("/dashboard");
      return;
    }
    setState(() {
      _currentIndex = i;
    });
  }

  getCartCount() async {
    Provider.of<CartCounter>(context, listen: false).getCount();
  }

  void initState() {
    _children = [
      Home(),
      // CategoryProducts(slug: ''),
      SwapScreen(),
      Wallet(),
      Profile()
    ];
    fetchAll();
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  bool _dialogShowing = false;

  Future<bool> willPop() async {
    print(_currentIndex);
    if (_currentIndex != 0) {
      fetchAll();
      setState(() {
        _currentIndex = 0;
      });
    } else {
      if (_dialogShowing) {
        return Future.value(false); // Dialog already showing, don't show again
      }
      setState(() {
        _dialogShowing = true;
      });

      final shouldPop = (await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Directionality(
                textDirection:
                    app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
                child: AlertDialog(
                  content: Text(
                      AppLocalizations.of(context)!.do_you_want_close_the_app),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                      },
                      child: Text(AppLocalizations.of(context)!.yes_ucf),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(AppLocalizations.of(context)!.no_ucf),
                    ),
                  ],
                ),
              );
            },
          )) ??
          false;

      setState(() {
        _dialogShowing = false; // Reset flag after dialog is closed
      });

      return shouldPop;
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Directionality(
        textDirection:
            app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            shape: CircleBorder(),
            onPressed: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Image.asset(
                "assets/images.jpg",
                fit: BoxFit.cover,
                height: 45,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          body: _children[_currentIndex],
          bottomNavigationBar: SizedBox(
            height: 85,
            child: StylishBottomBar(
              notchStyle: NotchStyle.circle,
              option: DotBarOptions(
                dotStyle: DotStyle.tile,
                gradient: const LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.pink,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              fabLocation: StylishBarFabLocation.center,
              hasNotch: true,
              onTap: onTapped,
              currentIndex: _currentIndex,
              backgroundColor: Colors.white.withOpacity(0.95),
              items: [
                BottomBarItem(
                    selectedColor: MyTheme.accent_color,
                    selectedIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        "assets/home.png",
                        color: _currentIndex == 0
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                    ),
                    unSelectedColor: Color.fromRGBO(168, 175, 179, 1),
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        "assets/home.png",
                        color: _currentIndex == 0
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                    ),
                    title: Text(AppLocalizations.of(context)!.home_ucf)),
                BottomBarItem(
                    selectedColor: MyTheme.accent_color,
                    selectedIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        "assets/swap.png",
                        color: _currentIndex == 1
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                    ),
                    unSelectedColor: Color.fromRGBO(168, 175, 179, 1),
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        "assets/swap.png",
                        color: _currentIndex == 1
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                    ),
                    title: Text(AppLocalizations.of(context)!.swap)),
                if (wallet_system_status.$)
                  BottomBarItem(
                      selectedColor: MyTheme.accent_color,
                      selectedIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          "assets/wallet.png",
                          color: _currentIndex == 2
                              ? MyTheme.accent_color
                              : Color.fromRGBO(153, 153, 153, 1),
                          height: 20,
                        ),
                      ),
                      unSelectedColor: Color.fromRGBO(168, 175, 179, 1),
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          "assets/wallet.png",
                          color: _currentIndex == 2
                              ? MyTheme.accent_color
                              : Color.fromRGBO(153, 153, 153, 1),
                          height: 20,
                        ),
                      ),
                      title: Text(AppLocalizations.of(context)!.my_wallet_ucf)),
                BottomBarItem(
                  selectedColor: MyTheme.accent_color,
                  selectedIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      "assets/profile.png",
                      color: _currentIndex == 3
                          ? MyTheme.accent_color
                          : Color.fromRGBO(153, 153, 153, 1),
                      height: 20,
                    ),
                  ),
                  unSelectedColor: Color.fromRGBO(168, 175, 179, 1),
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      "assets/profile.png",
                      color: _currentIndex == 3
                          ? MyTheme.accent_color
                          : Color.fromRGBO(153, 153, 153, 1),
                      height: 20,
                    ),
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.profile_ucf,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
