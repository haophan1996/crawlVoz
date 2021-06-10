import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Widget pageNavigation(BuildContext context, ItemScrollController scrollController, int currentPage, int totalPage, Function(String item) onCall,
    Function lastPage, Function firstPage) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Card(
      margin: EdgeInsets.only(bottom: 0),
      color: Theme.of(context).cardColor.withOpacity(0.8), //Colors.black.withOpacity(0.8),//Theme.of(context).cardColor,
      elevation: 20,
      child: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.066,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(),
                  child: IconButton(
                    splashColor: Colors.green,
                    onPressed: () async {
                      // final Email email = Email(
                      //   body: 'hey app is very perfect',
                      //   subject: 'Email subject',
                      //   recipients: ['haophan69@gmail.com'],
                      //   cc: ['cc@example.com'],
                      //   bcc: ['bcc@example.com'],
                      //   isHTML: false,
                      // );
                      // await FlutterEmailSender.send(email);
                    },
                    icon: Icon(
                      Icons.more_vert_rounded,
                    ),
                    iconSize: 25,
                  ),
                ),
                Spacer(),
                IconButton(
                  splashColor: Colors.green,
                  iconSize: 30,
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Get.defaultDialog(content: CircularProgressIndicator(), barrierDismissible: false, title: "Loading...");
                    firstPage();
                  },
                ),
                Container(
                  height: 36,
                  width: MediaQuery.of(context).size.width * 0.52,
                  child: ScrollablePositionedList.builder(
                    itemScrollController: scrollController,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: totalPage,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 100 : 0),
                        child: InkWell(
                          onTap: () {
                            if (index + 1 != currentPage) {
                              Get.defaultDialog(content: CircularProgressIndicator(), barrierDismissible: false, title: "Loading...");
                              onCall((index + 1).toString());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 2, left: 2),
                            constraints: BoxConstraints(minWidth: 33, minHeight: 35),
                            decoration: BoxDecoration(
                                color: (index + 1) == currentPage ? Theme.of(context).primaryColor : Colors.transparent,
                                border: Border.all(width: 2, color: (index + 1) == currentPage ? Colors.red : Colors.greenAccent),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            alignment: Alignment.center,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: (index + 1) == currentPage ? Colors.pink : Theme.of(context).primaryColor
                                  //controller.currentPage.value-1 == index ? Colors.red : Colors.black
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                    splashColor: Colors.green,
                    iconSize: 30,
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () {
                      Get.defaultDialog(content: CircularProgressIndicator(), barrierDismissible: false, title: "Loading...");
                      lastPage();
                    }),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                    splashColor: Colors.green,
                    icon: Icon(
                      Icons.message_outlined,
                    ),
                    onPressed: () {},
                    iconSize: 25,
                  ),
                )
              ],
            ),
          )),
    ),
  );
}
