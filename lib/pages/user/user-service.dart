import 'package:newflutterproject/common/api-service.dart';

class UserService {
  final apiService = ApiService();

  insert(String url, Object object) async {
    return await apiService.post(url, object);
  }

  edit(String url, Object object) async {
    return await apiService.put(url, object);
  }

  Future get(String url, Map query) async {
    return await apiService.get(url, query);
  }

  list(String url, Map query) async {
    return await apiService.get(url, query);
  }

  delete(String url, Map query) async {
    return await apiService.delete(url, query);
  }
}