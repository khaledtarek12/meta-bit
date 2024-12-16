import 'package:MetaBit/app_config.dart';
import 'package:MetaBit/repositories/api-request.dart';
import 'package:MetaBit/data_model/language_list_response.dart';
import 'package:MetaBit/helpers/shared_value_helper.dart';

class LanguageRepository {
  Future<LanguageListResponse> getLanguageList() async {
    String url = ("${AppConfig.BASE_URL}/languages");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    //print(response.body.toString());
    return languageListResponseFromJson(response.body);
  }
}
