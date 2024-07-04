import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/controllers/home_controller.dart';
import 'package:kikwa/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kikwa/views/intro_screen/intro_screen.dart';
import '../../widgets_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        auth.authStateChanges().listen((User? user) {
          if (user == null && mounted) {
            Get.offAll(() => const IntroScreen());
          } else {
            Get.to(() => const Home());
          }
        });
        Get.offAll(() => const IntroScreen());
      },
    );
  }

  @override
  void initState() {
    changeScreen();
    Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                )),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}
