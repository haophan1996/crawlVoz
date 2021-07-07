import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vozforums/GlobalController.dart';
import 'package:vozforums/Page/Pop/PopController.dart';
import '../View/ViewController.dart';

class Popup extends GetView<PopController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          color: Theme.of(context).backgroundColor.withOpacity(0.9),
        ),
        child: GetBuilder<GlobalController>(
          builder: (globalController) {
            return ListView.builder(
              itemCount: globalController.alertList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 0.5, color: Theme.of(context).primaryColor),
                  )),
                  child: CupertinoButton(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: globalController.alertList.elementAt(index)['username'], style: TextStyle(color: Colors.blue)),
                          TextSpan(
                              text: globalController.alertList.elementAt(index)['status'], style: TextStyle(color: Theme.of(context).primaryColor)),
                          TextSpan(text: globalController.alertList.elementAt(index)['threadName'] + '\n', style: TextStyle(color: Colors.blue)),
                          TextSpan(
                              text: globalController.alertList.elementAt(index)['time'],
                              style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                        ],
                      ),
                    ),
                    onPressed: () {
                      GlobalController.i.tagView.add(globalController.alertList.elementAt(index)['threadName']);
                      if (globalController.alertList.elementAt(index)['link'].toString().contains('conversations/messages')) {
                        controller.view = 1;
                      } else {
                        controller.view = 0;
                      }
                      Get.lazyPut<ViewController>(() => ViewController(), tag: GlobalController.i.tagView.last);
                      Get.toNamed("/ViewPage", arguments: [
                        globalController.alertList.elementAt(index)['threadName'],
                        globalController.alertList.elementAt(index)['link'],
                        '',
                        controller.view
                      ]);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
