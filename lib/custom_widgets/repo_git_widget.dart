import 'dart:async';
import 'package:assign01/custom_widgets/repo_desc.dart';
import 'package:assign01/model/repo_git.dart';
import 'package:assign01/network/github_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../get/repo_controller.dart';
import '../utils/colors.dart';

enum TypeList { trending, bookmark }

class RepoGitWidget extends StatelessWidget {
  RepoGitWidget(
      {super.key,
      required this.repo,
      required this.index,
      required this.typeList});
  GithubRepo repo;
  final int index;
  final TypeList typeList;
  final RepoController stateController = Get.find<RepoController>();
  @override
  Widget build(BuildContext context) {
    print(stateController.listRepoTrending[index].toString());
    return Container(
      color: dartColor,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: lightColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.book_outlined,
                      size: 16,
                      color: lightColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        _lauchUrl(Uri.parse(
                            'https://github.com${repo.url ?? 'https://github.com'}'));
                      },
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        repo.name!,
                        style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            decorationColor: secondaryColor),
                      ),
                    )
                  ],
                ),
              ),
              repo.bookmarked!
                  ? IconButton(
                      onPressed: () {
                        GithubApi().delBookmark(repo.name!).then((_) {
                          handleOnPressBookmark();
                        });
                      },
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.yellow,
                      ))
                  : IconButton(
                      onPressed: () {
                        GithubApi().Bookmark(repo.name!).then((_) {
                          handleOnPressBookmark();
                        });
                      },
                      icon: const Icon(
                        Icons.bookmark_outline,
                        color: lightColor,
                      ))
            ]),
            ExpandableDescription(description: repo.description!,),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color:repo.color!=''?
                        Color(int.parse(repo.color!.replaceFirst('#', '0xFF'))):Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  repo.lang!,
                  style: const TextStyle(color: lightColor, fontSize: 16),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.star_border_outlined,
                  size: 18,
                  color: lightColor,
                ),
                Text(
                  repo.stars!,
                  style: const TextStyle(color: lightColor, fontSize: 16),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.share_outlined,
                  size: 18,
                  color: lightColor,
                ),
                Text(
                  repo.fork!,
                  style: const TextStyle(color: lightColor, fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Build by :",
                      style: TextStyle(color: lightColor, fontSize: 16),
                    ),
                    ...buildAvatarContributors(repo.contributors!),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_outlined,
                      size: 18,
                      color: lightColor,
                    ),
                    Text(repo.starsToday!,
                        style: const TextStyle(color: lightColor, fontSize: 16)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _lauchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void handleOnPressBookmark() {
    if (typeList == TypeList.trending) {
      stateController.listRepoTrending[index].bookmarked =
          !(stateController.listRepoTrending[index].bookmarked)!;
    } else if (typeList == TypeList.bookmark) {
      stateController.listRepoBookmark[index].bookmarked =
          !(stateController.listRepoBookmark[index].bookmarked)!;
      stateController.listRepoBookmark.removeAt(index);
    }
    stateController.refreshList();
  }

  List<Widget> buildAvatarContributors(List<String> avatars) {
    List<Widget> avatarWidgets = [];
    for (var avatar in avatars) {
      avatarWidgets.add(
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              avatar,
              height: 20,
              width: 20,
            ),
          ),
        ),
      );
    }
    return avatarWidgets;
  }
}
