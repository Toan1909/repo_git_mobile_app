import 'package:assign01/get/repo_controller.dart';
import 'package:assign01/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_widgets/repo_git_widget.dart';
class BookmarkPage extends StatelessWidget {
  BookmarkPage({super.key}) {
    bookmarkController.loadListRepoBookmark();
  }
  final RepoController bookmarkController = Get.find<RepoController>();
  @override
  Widget build(BuildContext context) {
    return Obx( ()=>
      bookmarkController.listRepoBookmark.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Bookmark Empty!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
                itemCount: bookmarkController.listRepoBookmark.length,
                itemBuilder: (context, index) {
                  return RepoGitWidget(
                    repo: bookmarkController.listRepoBookmark[index],
                    index: index,
                    typeList: TypeList.bookmark,
                  );
                },
              ),
    );

  }
}
