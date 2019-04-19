import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = "https://dfb092f4.ngrok.io";

class ApiService {
  static Future obter(String controller, int id) {
    var url = baseUrl + "/api/" + controller + "/get/" + id.toString();
    return http.get(url);
  }

  static Future listar(String controller) {
    var url = baseUrl + "/api/" + controller + "/list?pageIndex=1&pageSize=5000";
    return http.get(url, headers: _getHeaders());
  }

    static Future editar(String controller, int id) {
    var url = baseUrl + "/api/" + controller + "/edit/" + id.toString();
    return http.put(url, body: jsonEncode(id), headers: _getHeaders());
  }

  static Future excluir(String controller, int id) {
    var url = baseUrl + "/api/" + controller + "/delete/" + id.toString();
    return http.delete(url);
  }

   static _getHeaders() {
    return { 'Accept': 'application/json', 'Content-Type': 'application/json' };
  }
}