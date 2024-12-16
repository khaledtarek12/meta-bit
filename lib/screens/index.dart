import 'package:MetaBit/helpers/addons_helper.dart';
import 'package:MetaBit/helpers/auth_helper.dart';
import 'package:MetaBit/helpers/business_setting_helper.dart';
import 'package:MetaBit/helpers/shared_value_helper.dart';
import 'package:MetaBit/helpers/system_config.dart';
import 'package:MetaBit/presenter/currency_presenter.dart';
import 'package:MetaBit/providers/locale_provider.dart';
import 'package:MetaBit/screens/main.dart';
import 'package:MetaBit/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  Index({super.key, this.goBack = true});
  bool? goBack;

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Future<String?> getSharedValueHelperData() async {
    access_token.load().whenComplete(() {
      AuthHelper().fetch_and_set();
    });
    AddonsHelper().setAddonsData();
    BusinessSettingHelper().setBusinessSettingData();
    await app_language.load();
    await app_mobile_language.load();
    await app_language_rtl.load();
    await system_currency.load();
    Provider.of<CurrencyPresenter>(context, listen: false).fetchListData();

    // print("new splash screen ${app_mobile_language.$}");
    // print("new splash screen app_language_rtl ${app_language_rtl.$}");

    return app_mobile_language.$;
  }

  @override
  void initState() {
    // TODO: implement initState
    getSharedValueHelperData().then((value) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        SystemConfig.isShownSplashScreed = true;
        Provider.of<LocaleProvider>(context, listen: false)
            .setLocale(app_mobile_language.$!);
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemConfig.context ??= context;
    return Scaffold(
      body: SystemConfig.isShownSplashScreed
          ? Main(
              go_back: widget.goBack,
            )
          : SplashScreen(),
    );
  }
}
