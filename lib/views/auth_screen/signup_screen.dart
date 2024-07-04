import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/validButton.dart';
import '../home_screen/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      isPass: false,
                      controller: nameController),
                  customTextField(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: emailController),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      isPass: true,
                      controller: passwordController),
                  customTextField(
                      title: retypePassword,
                      hint: passwordHint,
                      isPass: true,
                      controller: passwordRetypeController),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextButton(
                  //         onPressed: () {}, child: forgetPass.text.make())),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.indigo,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                        checkColor: whiteColor,
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "J'accepte ",
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: termAndCond,
                              style:
                                  TextStyle(fontFamily: bold, color: redColor)),
                          TextSpan(
                              text: " & ",
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: privacyPolicy,
                              style:
                                  TextStyle(fontFamily: bold, color: redColor)),
                        ])),
                      ),
                    ],
                  ),
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.indigo),
                        )
                      : validButton(
                          color: isCheck == true ? Colors.indigo : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isloading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: loggedout);
                                controller.isloading(false);
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: alreadHaveAccount,
                        style: TextStyle(fontFamily: bold, color: fontGrey)),
                    TextSpan(
                        text: login,
                        style: TextStyle(fontFamily: bold, color: redColor)),
                  ])).onTap(() {
                    Get.back();
                  })
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
