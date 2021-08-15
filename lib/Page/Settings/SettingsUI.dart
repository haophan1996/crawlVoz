import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:nextvoz/GlobalController.dart';
import '/Page/reuseWidget.dart';
import '/Page/Settings/SettingsController.dart';

class SettingsUI extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: preferredSize(context, 'setPage'.tr, ''),
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(top: 20, left: 50, right: 50),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'lang'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  FlutterReactionButton(
                    onReactionChanged: (reaction, i) {
                      controller.langIndex = i;
                      //await controller.setLang(i);
                    },
                    reactions: controller.flagsReactions,
                    initialReaction: controller.flagsReactions[controller.getLang()],
                    boxRadius: 10,
                    boxAlignment: AlignmentDirectional.bottomEnd,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'fontSizeView'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Expanded(
                        child: Slider(
                            divisions: 30,
                            label: controller.fontSizeView.string,
                            value: controller.fontSizeView.value,
                            max: 40.0,
                            min: 10.0,
                            onChanged: (value) {
                              controller.fontSizeView.value = value;
                            }),
                      ))
                ],
              ), //fontsize
              Row(
                children: [
                  Text(
                    'scrollToMyRepAfterPost'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.switchValuePost.value,
                      onChanged: (value) {
                        controller.switchValuePost.value = value;
                      },
                    ),
                  )
                ],
              ), //scroll post
              Row(
                children: [
                  Text(
                    'showImage'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.switchImage.value,
                      onChanged: (value) {
                        controller.switchImage.value = value;
                      },
                    ),
                  )
                ],
              ), //show images
              Row(
                children: [
                  Text(
                    'appSignature'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.switchSignature.value,
                      onChanged: (value) {
                        controller.switchSignature.value = value;
                      },
                    ),
                  )
                ],
              ), //app signature
              Row(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'defaultsPage'.tr,style: TextStyle(color: Get.theme.primaryColor, fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                          text: '\n${GlobalController.i.userStorage.read('defaultsPage_title') ?? 'Home'}'.tr,style: TextStyle(color: Colors.grey, )
                      )
                    ]),
                  ),
                  Spacer(),
                  Obx(
                    () => CupertinoSwitch(
                      value: controller.switchDefaultsPage.value,
                      onChanged: (value) {
                        controller.switchDefaultsPage.value = value;
                      },
                    ),
                  )
                ],
              ), //app signature

              CupertinoButton(
                  child: Text('Save'),
                  onPressed: () {
                    controller.saveButton();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
