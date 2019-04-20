import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String api = 'a64f355c.ngrok.io';
  final client = http.Client();

  get(String url, Map query) async {
    url += _getUrlQuery(query);

    var response = await client.get(_getApiUrl(url), headers: _getHeaders());

    return response.body;
  }

  Future post(String url, Object object) async {
    var response = await client.post(_getApiUrl(url),
        body: json.encode(object), headers: _getHeaders());
    print(response.body);
    return response.body;
  }

  put(String url, Object object) async {
    var response = await client.post(_getApiUrl(url),
        body: json.encode(object), headers: _getHeaders());
    print(response.body);
    return response.body;
  }

  delete(String url, int id) async {
    var response = await client.delete(_getApiUrl(url + id.toString()),
        headers: _getHeaders());

    return response.body;
  }

  _getHeaders() {
    return {'Accept': 'application/json', 'Content-Type': 'application/json'};
  }

  _getUrlQuery(Map query) {
    var queryUrl = '';

    for (var item in query.keys) {
      if (item == null) continue;

      if (queryUrl.indexOf('?') < 0)
        queryUrl += '?';
      else
        queryUrl += '&';

      queryUrl += item + '=' + query[item].toString();
    }

    return queryUrl;
  }

  String _getApiUrl(String url) {
    return Uri.decodeFull(Uri.https(api, url).toString());
  }
}
