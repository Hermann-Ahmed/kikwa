import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/controllers/cart_controller.dart';
import 'package:kikwa/views/cart_screen/payement_method.dart';
import 'package:kikwa/widgets_common/custom_textfield.dart';
import 'package:get/get.dart';

import '../../widgets_common/validButton.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Informations pour la réservation"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
        leading: Icon(Icons.arrow_back_ios).onTap(()=> Get.back()),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: context.screenWidth - 60,
            child: validButton(
                color: Colors.indigo,
                onPress: () {
                  if (controller.addressController.text.isEmpty && controller.phoneController.text.isEmpty && controller.postalcodeController.text.isEmpty) {
                     VxToast.show(context, msg: "Remplissez les champs s'il vous plait !");
                  }
                  else
                  {
                    Get.to(() => const PayementMethods());
                  }
                },
                textColor: whiteColor,
                title: "Continuer")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "avenue kondol Béaloum",
                isPass: false,
                title: "Adresse",
                controller: controller.addressController),
            customTextField(
                hint: "N'Djamena",
                isPass: false,
                title: "Ville",
                controller: controller.cityController),
            customTextField(
                hint: "Chad",
                isPass: false,
                title: "Pays",
                controller: controller.stateController),
            customTextField(
                hint: "Code postal",
                isPass: false,
                title: "Code postal",
                controller: controller.postalcodeController),
            customTextField(
                hint: "+23562401156",
                isPass: false,
                title: "Telephone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
