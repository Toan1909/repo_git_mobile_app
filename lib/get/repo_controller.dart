import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/repo_git.dart';
import '../network/github_api.dart';

class RepoController extends GetxController {
  final listRepoTrending = <GithubRepo>[].obs;
  final listRepoBookmark = <GithubRepo>[].obs;

  Future<void> loadListRepoTrending() async {
    listRepoTrending.value = await GithubApi().trendingRepos();
  }

  Future<void> loadListRepoBookmark() async {
    listRepoBookmark.value = await GithubApi().listBookmark();
  }
  void refreshList() {
    listRepoTrending.refresh();
    listRepoBookmark.refresh();
  }
}
