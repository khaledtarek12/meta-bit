import 'dart:convert';

import 'package:MetaBit/helpers/auth_helper.dart';
import 'package:MetaBit/helpers/system_config.dart';
import 'package:MetaBit/middlewares/middleware.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class BannedUser extends Middleware {
  @override
  bool next(http.Response response) {
    var jsonData = jsonDecode(response.body);
    if (jsonData.runtimeType != List &&
        jsonData.containsKey("result") &&
        !jsonData['result']) {
      if (jsonData.containsKey("status") && jsonData['status'] == "banned") {
        AuthHelper().clearUserData();
        if (SystemConfig.context != null) {
          SystemConfig.context!.go('/');
        }

        return false;
      }
    }
    return true;
  }
}
