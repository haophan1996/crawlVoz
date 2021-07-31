import 'package:get/get.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import '/GlobalController.dart';
import '/Page/reuseWidget.dart';

class SettingsController extends GetxController {
  RxDouble fontSizeView = 15.0.obs;
  RxBool switchValuePost = true.obs, switchImage = true.obs, switchSignature = true.obs, switchDefaultsPage = true.obs;
  var langIndex ;
  getLang(){
    return GlobalController.i.userStorage.read('lang');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    langIndex = GlobalController.i.userStorage.read('lang');
    fontSizeView.value = GlobalController.i.userStorage.read('fontSizeView');
    switchValuePost.value = GlobalController.i.userStorage.read('scrollToMyRepAfterPost');
    switchImage.value = GlobalController.i.userStorage.read('showImage');
    switchSignature.value = GlobalController.i.userStorage.read('signature');

    if (GlobalController.i.userStorage.read('defaultsPage') != null)
    switchDefaultsPage.value = GlobalController.i.userStorage.read('defaultsPage');
  }

  @override
  onClose() async {
    super.onClose();
    fontSizeView.close();
    switchValuePost.close();
    switchImage.close();
    switchSignature.close();
    switchDefaultsPage.close();
  }
  
  saveButton() async {
    await GlobalController.i.userStorage.write('scrollToMyRepAfterPost', switchValuePost.value);
    await GlobalController.i.userStorage.write('fontSizeView', fontSizeView.value);
    Get.updateLocale(GlobalController.i.langList.elementAt(langIndex));
    await GlobalController.i.userStorage.write('showImage', switchImage.value);
    await GlobalController.i.userStorage.write('defaultsPage', switchDefaultsPage.value);
    await GlobalController.i.userStorage.write('signature', switchSignature.value);
    await GlobalController.i.userStorage.write('lang', langIndex).then((value) => Get.back());
  }


  final flagsReactions = [
    Reaction(
      previewIcon: buildFlagsPreviewIcon('assets/languages/en.png', 'English'),
      icon: buildIcon('assets/languages/en.png', 'English'),
    ),
    Reaction(
      previewIcon: buildFlagsPreviewIcon('assets/languages/vn.png', 'Tiếng Việt'),
      icon: buildIcon('assets/languages/vn.png', 'Tiếng Việt'),
    ),
  ];
}
