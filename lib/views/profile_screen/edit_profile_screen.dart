import 'dart:io';

import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/widgets_common/custom_textfield.dart';
import 'package:kikwa/widgets_common/validButton.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return
      Scaffold(
        backgroundColor: Colors.indigo,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios, color: Colors.white,).onTap(() => Get.back(),),
        ),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              validButton(
                  color: Colors.indigo,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              15.heightBox,
              customTextField(
                hint: nameHint,
                title: name,
                isPass: false,
                controller: controller.nameController,
              ),
              10.heightBox,
              customTextField(
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                  controller: controller.oldpassController),
              10.heightBox,
              customTextField(
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                  controller: controller.newpassController),
              18.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.indigo),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: validButton(
                          color: Colors.indigo,
                          onPress: () async {
                            controller.isloading(true);

                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            // Le cas où tout est nul (Le user ne change que son image)
                            if (controller.nameController.text.isEmpty && controller.oldpassController.text.isEmpty && controller.newpassController.text.isEmpty) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: data['password'],
                                  newpassword:
                                      data['password']);
                              
                              await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: data['name'],
                                password: data['password'],
                              );
                              VxToast.show(context, msg: 'Modifié');
                              Get.back();
                            }

                            // Le cas où le nom n'est pas nul (Le user ne change que son image et son nom)
                            if (controller.nameController.text.isNotEmptyAndNotNull && controller.oldpassController.text.isEmpty && controller.newpassController.text.isEmpty) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: data['password'],
                                  newpassword:
                                      data['password']);
                              
                              await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: data['password'],
                              );
                              VxToast.show(context, msg: 'Modifié');
                              Get.back();
                            }

                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword:
                                      controller.newpassController.text);

                              await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text,
                              );
                              VxToast.show(context, msg: 'Modifié');
                              Get.back();
                            } else {
                              VxToast.show(context, msg: "Ancien mot de passe erroné");
                              controller.isloading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Enregistrer"),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      );
  }
}
