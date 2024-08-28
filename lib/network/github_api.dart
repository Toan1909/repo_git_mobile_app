import 'dart:async';
import 'package:assign01/Model/user.dart';
import 'package:assign01/model/repo_git.dart';
import 'package:assign01/network/github_service.dart';
import 'package:dio/dio.dart';

class GithubApi {
  Future<User> signUp(String email, String fullName, String pass) async {
    var c = Completer<User>();

    try {
      var response = await GitService.instance.dio.post(
        "/user/sign-up",
        data: {
          'fullName': fullName,
          'email': email,
          'password': pass,
        },
      );
      // Kiểm tra mã trạng thái
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Dữ liệu phản hồi: ${response.data}');
        var result = User.fromJson(response.data['data']);
        c.complete(result);
      } else {
        c.completeError('Lỗi với mã trạng thái: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        c.completeError("Conflict Account");
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }

    return c.future;
  }

  Future<User> signIn(String email, String pass) async {
    var c = Completer<User>();
    //const url = 'https://26b9-1-53-27-214.ngrok-free.app/user/sign-up';
    try {
      var response = await GitService.instance.dio.post(
        "/user/sign-in",
        data: {
          'email': email,
          'password': pass,
        },
      );
      // Kiểm tra mã trạng thái
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Dữ liệu phản hồi: ${response.data}');
        var result = User.fromJson(response.data['data']);
        c.complete(result);
      } else {
        c.completeError('Lỗi với mã trạng thái: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        c.completeError("Unauthorized");
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }

    return c.future;
  }

  Future<List<GithubRepo>> trendingRepos() async {
    var c = Completer<List<GithubRepo>>();
    //const url = 'https://26b9-1-53-27-214.ngrok-free.app/user/sign-up';
    try {
      var response = await GitService.instance.dio.get(
        "/github/trending",
      );
      // Kiểm tra mã trạng thái
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('Dữ liệu phản hồi: ${response.data}');
        var result = GithubRepo.parseRepoList(response.data);
        c.complete(result);
      } else {
        c.completeError('Lỗi với mã trạng thái: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        c.completeError("Not Found");
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }

    return c.future;
  }

  Future<GithubRepo> getRepoByName(String name) async {
    var c = Completer<GithubRepo>();
    //const url = 'https://26b9-1-53-27-214.ngrok-free.app/user/sign-up';
    try {
      var response = await GitService.instance.dio
          .post("/github/get-repo", data: {'name': name});
      // Kiểm tra mã trạng thái
      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = GithubRepo.fromJson(response.data['data']);
        c.complete(result);
      } else {
        c.completeError('Lỗi với mã trạng thái: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        c.completeError("Not Found");
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }

  Future<void> Bookmark(String name) async {
    var c = Completer<void>();
    //const url = 'https://26b9-1-53-27-214.ngrok-free.app/user/sign-up';
    try {
      var response = await GitService.instance.dio
          .post("/bookmark/add", data: {"repoName": name});
      // Kiểm tra mã trạng thái
      if (response.statusCode == 200 || response.statusCode == 201) {
        c.complete();
      } else {
        c.completeError('Lỗi với mã trạng thái: ${response.statusCode}');
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }

  Future<void> delBookmark(String name) async {
    var c = Completer<void>();
    //const url = 'https://26b9-1-53-27-214.ngrok-free.app/user/sign-up';
    try {
      var response = await GitService.instance.dio
          .delete("/bookmark/delete", data: {"repoName": name});
      // Kiểm tra mã trạng thái
      if (response.statusCode == 200 || response.statusCode == 201) {
        c.complete();
      } else {
        c.completeError('Lỗi với mã trạng thái: ${response.statusCode}');
      }
    } catch (e) {
      c.completeError(e.toString());
    }
    return c.future;
  }

  Future<List<GithubRepo>> listBookmark() async {
    var c = Completer<List<GithubRepo>>();
    //const url = 'https://26b9-1-53-27-214.ngrok-free.app/user/sign-up';
    try {
      var response = await GitService.instance.dio.get(
        "/bookmark/list",
      );
      // Kiểm tra mã trạng thái
      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = GithubRepo.parseRepoList(response.data);
        c.complete(result);
      } else {
        c.completeError('Lỗi với mã trạng thái: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        c.completeError("Not Found");
      } else {
        c.completeError(e.message as Object);
      }
    } catch (e) {
      c.completeError(e.toString());
    }

    return c.future;
  }
}
