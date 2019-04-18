import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://2216e81a.ngrok.io";

class ApiService {
  static Future httpGet(String entity) {
    var url = baseUrl + "/api/" + entity + "/Get";
    return http.get(url);
  }

  static Future httpList(String entity) {
    var url = baseUrl + "/api/" + entity + "/list?pageIndex=1&pageSize=5000";
    return http.get(url);
  }
}