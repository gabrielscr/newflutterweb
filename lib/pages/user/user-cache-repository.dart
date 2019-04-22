import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:newflutterproject/common/api-service.dart';
import 'package:newflutterproject/common/cache.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/domain/users.dart';
import 'package:newflutterproject/pages/user/user-service.dart';

class UserCacheRepository extends UserService {
  final int pageSize = 50;
  final Cache<User> cache;
  final ApiService api = ApiService();

  final pagesInProgress = Set<int>();
  final pagesCompleted = Set<int>();
  final completers = HashMap<int, Set<Completer>>();

  int totalUsers;

  UserCacheRepository({this.cache});

  @override
  Future<User> getUsers(int index) {
    final pageIndex = pageIndexFromUserIndex(index);

    if (pagesCompleted.contains(pageIndex)) {
      return cache.get(index);
    } else {
      if (!pagesInProgress.contains(pageIndex)) {
        pagesInProgress.add(pageIndex);
        var future = api.get('/api/person/list',
            {'search': null, 'pageSize': 500, 'pageIndex': 1});
        future.asStream().listen(onData);
      }
      return buildFuture(index);
    }
  }

  Future<User> buildFuture(int index) {
    var completer = Completer<User>();

    if (completers[index] == null) {
      completers[index] = Set<Completer>();
    }
    completers[index].add(completer);

    return completer.future;
  }

  void onData(Users users) {
    if (users != null) {
      totalUsers = users.totalUsers;
      pagesInProgress.remove(users.pageNumber);
      pagesCompleted.add(users.pageNumber);

      for (int i = 0; i < pageSize; i++) {
        int index = users.pageSize * users.pageNumber + i;
        User user = users.users[i];

        cache.put(index, user);
        Set<Completer> comps = completers[index];

        if (comps != null) {
          for (var completer in comps) {
            completer.complete(user);
          }
          comps.clear();
        }
      }
    } else {
      log("CachingRepository.onData(null)!!!");
    }
  }

  int pageIndexFromUserIndex(int userIndex) {
    return userIndex ~/ pageSize;
  }
}
