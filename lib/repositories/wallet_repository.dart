import 'package:MetaBit/app_config.dart';
import 'package:MetaBit/data_model/wallet_balance_response.dart';
import 'package:MetaBit/data_model/wallet_recharge_response.dart';
import 'package:MetaBit/middlewares/banned_user.dart';
import 'package:MetaBit/repositories/api-request.dart';

import '../helpers/main_helpers.dart';

class WalletRepository {
  Future<dynamic> getBalance() async {
    String url = ("${AppConfig.BASE_URL}/wallet/balance");

    Map<String, String> header = commonHeader;

    header.addAll(authHeader);
    header.addAll(currencyHeader);

    final response = await ApiRequest.get(
        url: url, headers: header, middleware: BannedUser());
    return walletBalanceResponseFromJson(response.body);
  }

  Future<dynamic> getRechargeList({int page = 1}) async {
    String url = ("${AppConfig.BASE_URL}/wallet/history?page=$page");
    Map<String, String> header = commonHeader;

    header.addAll(authHeader);
    header.addAll(currencyHeader);
    final response = await ApiRequest.get(
        url: url, headers: header, middleware: BannedUser());

    return walletRechargeResponseFromJson(response.body);
  }
}
