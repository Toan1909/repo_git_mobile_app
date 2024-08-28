import 'package:assign01/custom_widgets/repo_git_widget.dart';
import 'package:assign01/get/repo_controller.dart';
import 'package:assign01/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendingReposPage extends StatelessWidget {
  final RepoController trendingController = Get.find<RepoController>();
  TrendingReposPage({super.key, required this.scrollController}) {
    trendingController.loadListRepoTrending();
  }
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          controller: scrollController,
          itemCount: trendingController.listRepoTrending.length,
          itemBuilder: (context, index) {
            return RepoGitWidget(
              repo: trendingController.listRepoTrending[index],
              index: index,
              typeList: TypeList.trending,
            );
          },
        ));
  }
}
