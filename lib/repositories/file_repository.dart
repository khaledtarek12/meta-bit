import 'package:MetaBit/app_config.dart';
import 'package:MetaBit/middlewares/banned_user.dart';
import 'package:MetaBit/repositories/api-request.dart';
import 'dart:convert';
import 'package:MetaBit/data_model/simple_image_upload_response.dart';
import 'package:MetaBit/helpers/shared_value_helper.dart';

class FileRepository {
  Future<dynamic> getSimpleImageUploadResponse(
      String image, String filename) async {
    var post_body = jsonEncode({"image": "${image}", "filename": "$filename"});

    String url = ("${AppConfig.BASE_URL}/file/image-upload");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: post_body,
        middleware: BannedUser());

    return simpleImageUploadResponseFromJson(response.body);
  }
}
