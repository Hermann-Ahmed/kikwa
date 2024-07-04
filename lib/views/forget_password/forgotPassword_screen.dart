import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/views/auth_screen/login_screen.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  TextEditingController forgetPwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Mot de passe oublié".text.makeCentered(),
        leading: Icon(Icons.arrow_back_ios_new).onTap(() => Get.back(),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: forgetPwdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "exemple@gmail.com",
                      label: "Email".text.make()
                    ),
                  ),
                ),
                10.heightBox,
                ElevatedButton(onPressed: () async{
                  var forgotEmail = forgetPwdController.text.trim();
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail).then((value){
                      Get.off(()=> LoginScreen());
                      VxToast.show(context, msg: "Email envoyé ! Vérifiez votre adresse mail");
                    });
                  } on FirebaseAuthException catch (e) {
                    print("Error $e");
                  }
                }, child: "Envoyer".text.make())
              ],
            ),
          ),
        ),
      ),
    );
  }
}