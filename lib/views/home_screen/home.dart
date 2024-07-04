import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/controllers/home_controller.dart';
import 'package:kikwa/views/cart_screen/cart_screen.dart';
import 'package:kikwa/views/category_screen/category_screen.dart';
import 'package:kikwa/views/home_screen/home_screen.dart';
import 'package:kikwa/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

import '../../widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async{
        showDialog(barrierDismissible: false, context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Obx(() => navBody.elementAt(controller.currentNavIndex.value)),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: Colors.indigo,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
