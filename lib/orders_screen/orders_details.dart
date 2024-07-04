import 'package:get/get.dart';

import '../consts/consts.dart';
import 'components/order_place_details.dart';
import 'components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Details de reservation".text.fontFamily(bold).color(darkFontGrey).make(),
        leading: Icon(Icons.arrow_back_ios).onTap(()=>Get.back()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(color: redColor, icon: Icons.done, title: "Placé", showDone: data['order_placed']),
              orderStatus(color: Colors.blue, icon: Icons.thumb_up, title: "Confirmé", showDone: data['order_confirmed']),
              orderStatus(color: Colors.yellow, icon: Icons.car_crash, title: "En reservation", showDone: data['order_on_delivery']),
              orderStatus(color: Colors.purple, icon: Icons.done_all_rounded, title: "Reservé", showDone: data['order_delivered']),

              const Divider(),
              10.heightBox,

              Column(
                children: [
                  orderPlaceDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Code de reservation",
                      title2: "Méthode d’expédition"
                  ),
                  orderPlaceDetails(
                      d1: intl.DateFormat.yMd().format(data['order_date'].toDate()) ,
                      d2: data['payment_method'],
                      title1: "Date de reservation",
                      title2: "Methode de paiement"
                  ),
                  orderPlaceDetails(
                      d1: "Impayée",
                      d2: "Reservation",
                      title1: "Statut du paiement",
                      title2: "Statut de reservation"
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Adresse du locataire".text.bold.make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        5.widthBox,
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start ,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Montant total".text.bold.make(),
                              "${data['total_amount']} Fcfa".text.color(redColor).bold.make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Produit reservé".text.size(16).color(darkFontGrey).bold.fontFamily(semibold).makeCentered(),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['vendors'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: data['vendors'][index]['title'],
                        title2: data['vendors'][index]['tprice'],
                        d1: "",
                        d2: "Remboursable",
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Container(
                      //     width: 30,
                      //     height: 20,
                      //     color: Color(data['vendors'][index]['color']),
                      //   ),
                      // ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,
              /*Row(
                children: [
                  "SUB TOTAL:".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                  "TAX:".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                  "SHIPPING COAST:".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                  "DISCOUNT :".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

