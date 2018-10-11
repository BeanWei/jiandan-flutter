import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

final _httpClient = HttpClient();

Future<String> getRequest(Uri uri) async {
  var request = await _httpClient.getUrl(uri);
  var response = await request.close();
  return response.transform(utf8.decoder).join();
}

class HttpUtils {
  static Future<dynamic> get(String url, Function callback, {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }

    try {
     http.Response res = await http.get(url);
     if (callback != null) {
       callback(res.body);
     } else {
       return res.body;
     }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      } else  {
        throw exception;
      }
    }
  }

  static void post(String url, Function callback, {Map<String, String> params, Function errorCallback}) async {
    try {
      http.Response res = await http.post(url, body: params);
      if (callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }
}