import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vozforums/GlobalController.dart';
import 'dart:io';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewController extends GetxController {
  final String _url = "https://voz.vn";
  final String _pageLink = "page-";
  late String fullUrl;
  var subHeader;
  List htmlData = [].obs;
  var _postContent;
  var _userPostDate;
  var _userName;
  var _userAvatar;
  var _userTitle;
  var _userLink;
  var _orderPost;
  late var _user;
  int lengthHtmlDataList = 0;

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final ScrollController listViewScrollController = ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  RxInt currentPage = 0.obs;
  RxInt totalPage = 0.obs;
  final int loadItems = 50;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    subHeader = Get.arguments[0];
    await loadUserPost(fullUrl = _url + Get.arguments[1]);
  }

  loadUserPost(String url) async {
    await GlobalController.i.getBody(url).then((value) async {
      lengthHtmlDataList = htmlData.length;
      value.getElementsByClassName("block block--messages").forEach((element) {
        var lastP = element.getElementsByClassName("pageNavSimple");
        if (lastP.length == 0) {
          currentPage.value = 1;
          totalPage.value = 1;
        } else {
          var naviPage = element.getElementsByClassName("pageNavSimple-el pageNavSimple-el--current").first.innerHtml.trim();
          currentPage.value = int.parse(naviPage.replaceAll(RegExp(r'[^0-9]\S*'), ""));
          totalPage.value = int.parse(naviPage.replaceAll(RegExp(r'\S*[^0-9]'), ""));
        }

        //Get post
        element.getElementsByClassName("message message--post js-post js-inlineModContainer").forEach((element) {
          _postContent = element.getElementsByClassName("message-body js-selectToQuote").map((e) => e.outerHtml).first;
          _userPostDate = element.getElementsByClassName("u-concealed").map((e) => e.getElementsByTagName("time")[0].innerHtml).first;
          _user = element.getElementsByClassName("message-cell message-cell--user");
          _userLink = _user.map((e) => e.getElementsByTagName("a")[1].attributes['href']).first!;
          _userTitle = _user.map((e) => e.getElementsByClassName("userTitle message-userTitle")[0].innerHtml).first;
          if (_user.map((e) => e.getElementsByTagName("img").length).toString() == "(1)") {
            _userAvatar = _user.map((e) => e.getElementsByTagName("img")[0].attributes['src']).first!;
          } else {
            _userAvatar = "no";
          }

          _userName = _user.map((e) => e.getElementsByTagName("a")[1].innerHtml).first;
          if (_userName.contains("span")) {
            _userName = _user.map((e) => e.getElementsByTagName("span")[0].innerHtml).first;
          }

          _orderPost = element
              .getElementsByClassName("message-attribution-opposite message-attribution-opposite--list")
              .map((e) => e.getElementsByTagName("a")[1].innerHtml)
              .first
              .trim();

          htmlData.add({
            "postContent": _removeTag(_postContent),
            "userPostDate": _userPostDate,
            "userName": _userName,
            "userLink": _userLink,
            "userTitle": _userTitle,
            "userAvatar": (_userAvatar == "no" || _userAvatar.contains("https://")) ? _userAvatar : _url + _userAvatar,
            "orderPost": _orderPost,
          });
        });
      });
      if (Get.isDialogOpen == true || refreshController.isLoading) {
        if (Get.isDialogOpen == true) Get.back();
        htmlData.removeRange(0, lengthHtmlDataList);
      }
      refreshController.loadComplete();
    });
  }

  getYoutubeID(String s) {
    return YoutubePlayer.convertUrlToId(s);
  }

  _removeTag(String content) {
    return content.replaceAll(
        RegExp(r'<div class="bbCodeBlock-expandLink js-expandLink"><a role="button" tabindex="0">Click to expand...</a></div>'), "");
  }

  setPageOnClick(String toPage) async {
    if (int.parse(toPage) > totalPage.value) {
      Get.defaultDialog(
          title: "Alert",
          content: Text("No More Page"),
          confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Touch anywhere to dismiss",
                style: TextStyle(fontSize: 13, color: Colors.black),
              )));
      refreshController.loadComplete();
    } else {
      await loadUserPost(fullUrl + _pageLink + toPage);
      itemScrollController.scrollTo(index: int.parse(toPage) + 1, duration: Duration(microseconds: 500), alignment: 0.735);
      listViewScrollController.jumpTo(-10.0);
    }
  }

  write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    await file.writeAsString(text);
    print('${directory.path}/my_file.txt');
    print(File('${directory.path}/my_file.txt').toString());
  }
}
