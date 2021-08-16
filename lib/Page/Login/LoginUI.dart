import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Page/reuseWidget.dart';
import '/GlobalController.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'LoginController.dart';

class LoginUI extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBarOnly('', []),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: TextField(
                controller: controller.textEditingControllerLogin,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: 'loginAccount'.tr,
                    labelStyle: TextStyle(color: Get.theme.primaryColor.withOpacity(0.7)),
                    fillColor: Get.theme.canvasColor,
                    filled: true,
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Get.theme.primaryColor, width: 1)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
              ),
            ),
            Obx(() => TextField(
                  controller: controller.textEditingControllerPassword,
                  obscureText: controller.isShowPass.value,
                  onSubmitted: (_) async => await controller.loginFunction(),
                  decoration: InputDecoration(
                      suffix: InkWell(
                        focusNode: FocusNode(skipTraversal: true),
                        onTap: () => {controller.isShowPass.value == true ? controller.isShowPass.value = false : controller.isShowPass.value = true},
                        child: Text(
                          controller.isShowPass.value == true ? 'hide'.tr : 'show'.tr,
                          style: TextStyle(color: Get.theme.primaryColor),
                        ),
                      ),
                      labelText: 'loginPassword'.tr,
                      labelStyle: TextStyle(color: Get.theme.primaryColor.withOpacity(0.7)),
                      fillColor: Get.theme.canvasColor,
                      filled: true,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Get.theme.primaryColor, width: 1)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
                )),
            Obx(() => Text(
                  controller.statusLogin.value,
                  style: TextStyle(color: Colors.red),
                )),
            customCupertinoButton(Alignment.center, EdgeInsets.only(top: 5, bottom: 5), Text('forgotPass'.tr), () async {
              await GlobalController.i.launchURL('https://voz.vn/lost-password/');
            }),
            customCupertinoButton(
                Alignment.center,
                EdgeInsets.zero,
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Text('login'.tr)),
                () async{
                //setDialog();
                  await controller.loginFunction();
                }),
            Text('or'.tr),
            Spacer(),
            SignInButton(Buttons.Google, onPressed: () {}),
            SignInButton(Buttons.FacebookNew, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
