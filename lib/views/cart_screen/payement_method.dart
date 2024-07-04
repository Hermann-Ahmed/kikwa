import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/consts/lists.dart';
import 'package:kikwa/controllers/cart_controller.dart';
import 'package:kikwa/views/home_screen/home.dart';
import 'package:get/get.dart';

import '../../widgets_common/validButton.dart';

class PayementMethods extends StatelessWidget {
  const PayementMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: context.screenWidth - 60,
              child: controller.placingOrder.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.indigo),
                      ),
                    )
                  : validButton(
                      color: Colors.indigo,
                      onPress: () async {
                        await controller.placeMyOrder(
                          vendorId: Get.find<CartController>().vendorID,
                            orderPaymentMethod:
                                paymentMethods[controller.paymentIndex.value],
                            totalAmount: controller.totalP.value);
                        await controller.clearCart();
          
                        // VxToast.show(context, msg: "Order placed successfully");
                        Get.offAll(const Home());
                      },
                      textColor: whiteColor,
                      title: "Reservé")),
        ),
        appBar: AppBar(
          title: "Choisissez le mode de paiement"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Obx(
          () => Column(
            children: List.generate(paymentMethodsImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? Colors.indigo
                            : Colors.transparent,
                        width: 4,
                      )),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(bold)
                              .size(16)
                              .make()),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
