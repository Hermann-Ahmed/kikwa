import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/views/cart_screen/shipping_screen.dart';
import 'package:kikwa/widgets_common/validButton.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../services/firestore_services.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      // bottomNavigationBar:  SizedBox(
      //     width: context.screenWidth - 60,
      //     child: validButton(
      //           color: redColor,
      //           onPress: () {
      //               Get.to(() => const ShippingDetails());
                  
      //           },
      //           textColor: whiteColor,
      //           title: "Proceed to shipping"),
      //     ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Mon Panier"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.indigo),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Votre panier est vide".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                          "${data[index]['img']}",
                          // height: 120,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        title:
                            "${data[index]['title']}"
                                .text
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                        subtitle: "${data[index]['tprice']} Fcfa"
                            .text
                            .color(redColor)
                            .bold
                            .make(),
                        trailing: const Icon(
                          Icons.delete,
                          color: redColor,
                        ).onTap(() {
                          FirestoreServices.deleteDocument(data[index].id);
                          VxToast.show(context,
                              msg: "Produit supprimé");
                        }),
                      );
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Prix total"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(() => "${controller.totalP.value}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(Colors.red)
                          .make()),
                      
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .roundedSM
                      .color(lightGolden)
                      .width(context.screenWidth - 60)
                      .make(),
                      10.heightBox,
                   SizedBox(
                    width: context.screenWidth - 60,
                    child: validButton(
                    color: Colors.indigo,
                    onPress: () {
                        Get.to(() => const ShippingDetails());
                      },
                      textColor: whiteColor,
                      title: "Procéder à la réservation"),
                ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
