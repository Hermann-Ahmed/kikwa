import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/controllers/auth_controller.dart';
import 'package:kikwa/views/auth_screen/signup_screen.dart';
import 'package:get/get.dart';
import 'package:kikwa/views/forget_password/forgotPassword_screen.dart';

import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/validButton.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: controller.emailController),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      isPass: true,
                      controller: controller.passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {Get.to(()=>ForgotpasswordScreen());}, child: forgetPass.text.make())),
                  5.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.indigo),
                        )
                      : validButton(
                          color: Colors.indigo,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isloading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isloading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  validButton(
                      color: lightGolden,
                      title: signup,
                      textColor: Colors.indigo,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  // loginWith.text.color(fontGrey).make(),
                  // 5.heightBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: List.generate(
                  //       3,
                  //       (index) => Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: CircleAvatar(
                  //               backgroundColor: lightGrey,
                  //               radius: 25,
                  //               child: Image.asset(
                  //                 socialIconList[index],
                  //                 width: 30,
                  //               ).onTap(() async {
                  //                 if (index == 1) {
                  //                   controller.isloading(true);
                  //                   await controller
                  //                       .signInWithGoogle()
                  //                       .then((value) {
                  //                     if (value != null) {
                  //                       return controller.storeUserData(
                  //                           name: currentUser!.displayName,
                  //                           email: currentUser!.email);
                  //                     }
                  //                   });
                  //                 }
                  //               }),
                  //             ),
                  //           )),
                  // ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
