import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/controllers/cart_controller.dart';
import 'package:kikwa/controllers/product_controller.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    var cartController = Get.put(CartController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: lightGrey,
          // appBar: AppBar(
          //   leading: IconButton(
          //       onPressed: () {
          //         controller.resetValues();
          //         Get.back();
          //       },
          //       icon: const Icon(Icons.arrow_back_ios)),
          //   title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          //   actions: [
          //     // IconButton(
          //     //   onPressed: () {},
          //     //   icon: const Icon(
          //     //     Icons.share,
          //     //   ),
          //     // ),
          //     Obx(
          //       () => IconButton(
          //         onPressed: () {
          //           if (controller.isFav.value) {
          //             controller.removeToWishlist(data.id, context);
          //           } else {
          //             controller.addToWishlist(data.id, context);
          //           }
          //         },
          //         icon: Icon(
          //           Icons.favorite_outline,
          //           color: controller.isFav.value ? redColor : darkFontGrey,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightBox,
                Stack(
                  children: [
                    VxSwiper.builder(
                            autoPlay: true,
                            height: 350,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            itemCount: data['p_imgs'].length,
                            itemBuilder: (context, index) {
                              return 
                               Image.network(
                                "${data['p_imgs'][index]}",
                                // width: double.infinity,
                                // fit: BoxFit.cover,
                              )
                              ;
                            }),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.brown,
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.brown.shade300,
                    //         blurRadius: 5,
                    //         spreadRadius: 3
                    //       )
                    //     ]
                    //   ),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(20),
                    //     child: Image.asset("assets/b1.jpg"),
                    //   ),
                    // ),
                    Positioned(child: Container(
                      margin: EdgeInsets.all(10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(child: Icon(Icons.arrow_back, color: Colors.indigo,)),
                    ).onTap(() => Get.back(),))
                  ],
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${data['p_name']}", style: Theme.of(context).textTheme.headlineMedium,),
                    Row(
                      children: [
                        "${data['p_rating']}".text.make(),
                        Icon(Icons.star, color: Colors.yellow,)
                      ],
                    )
                  ],
                ),
                10.heightBox,
                "${data['p_desc']}".text.make(),
                20.heightBox,
                 Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.indigo,),
                    10.widthBox,
                    Expanded(child: "${data['p_city']}, ${data['p_pays']}".text.make())
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    Icon(Icons.location_searching_rounded, color: Colors.indigo,),
                    "${data['p_address']}".text.make(),
                  ],
                ),
                100.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Prix".text.bold.make(),
                        Row(
                          children: [
                            Text("${data['p_price']} Fcfa/", style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 18,
                              fontWeight: FontWeight.w900
                            ),),
                            "Mois".text.make()
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: "Reserver".text.white.size(18).make(),
                      ),
                    ).onTap((){
                       cartController.vendorID = data['vendor_id'];
                        controller.addToCart(
                        context: context,
                        vendorID: data['vendor_id'],
                              // color: data['p_colors'][controller.colorIndex.value],
                        img: data['p_imgs'][0],
                        sellername: data['p_seller'],
                        title: data['p_name'],
                        tprice: data['tprice']);
                        VxToast.show(context, msg: "Ajouté au panier");
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
          //  Column(
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8),
          //         child: SingleChildScrollView(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               VxSwiper.builder(
          //                   autoPlay: true,
          //                   height: 350,
          //                   aspectRatio: 16 / 9,
          //                   viewportFraction: 1.0,
          //                   itemCount: data['p_imgs'].length,
          //                   itemBuilder: (context, index) {
          //                     return Image.network(
          //                       data["p_imgs"][index],
          //                       width: double.infinity,
          //                       fit: BoxFit.cover,
          //                     );
          //                   }),
          //               10.heightBox,
          //               title!.text
          //                   .size(16)
          //                   .color(darkFontGrey)
          //                   .fontFamily(semibold)
          //                   .make(),
          //               // 10.heightBox,
          //               // VxRating(
          //               //   isSelectable: false,
          //               //   value: double.parse(data['p_rating']),
          //               //   onRatingUpdate: (value) {},
          //               //   normalColor: textfieldGrey,
          //               //   selectionColor: golden,
          //               //   count: 5,
          //               //   maxRating: 5,
          //               //   size: 25,
          //               // ),
          //               10.heightBox,
          //               "${data['p_price']} Fcfa / mois"
          //                   .text
          //                   .color(redColor)
          //                   .fontFamily(bold)
          //                   .size(18)
          //                   .make(),
          //               10.heightBox,
          //               Row(
          //                 children: [
          //                   Expanded(
          //                       child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       "Bailleur".text.white.fontFamily(semibold).make(),
          //                       5.heightBox,
          //                       "${data['p_seller']}"
          //                           .text
          //                           .white
          //                           .fontFamily(semibold)
          //                           .color(darkFontGrey)
          //                           .make(),
          //                     ],
          //                   )),
          //                   // const CircleAvatar(
          //                   //   backgroundColor: Colors.white,
          //                   //   child: Icon(
          //                   //     Icons.message_rounded,
          //                   //     color: darkFontGrey,
          //                   //   ),
          //                   // ).onTap(() {
          //                   //   Get.to(() => const ChatScreen(), arguments: [
          //                   //     data['p_seller'],
          //                   //     data['vendor_id']
          //                   //   ]);
          //                   // })
          //                 ],
          //               )
          //                   .box
          //                   .height(60)
          //                   .padding(const EdgeInsets.symmetric(horizontal: 16))
          //                   .color(textfieldGrey)
          //                   .make(),
          //               20.heightBox,
          //               Obx(
          //                 () => Column(
          //                   children: [
          //                     // Row(
          //                     //   children: [
          //                     //     SizedBox(
          //                     //       width: 100,
          //                     //       child: "Color: "
          //                     //           .text
          //                     //           .color(textfieldGrey)
          //                     //           .make(),
          //                     //     ),
          //                     //     Row(
          //                     //       children: List.generate(
          //                     //           data['p_colors'].length,
          //                     //           (index) => Stack(
          //                     //                 alignment: Alignment.center,
          //                     //                 children: [
          //                     //                   VxBox()
          //                     //                       .size(40, 40)
          //                     //                       .roundedFull
          //                     //                       .color(Color(data['p_colors']
          //                     //                               [index])
          //                     //                           .withOpacity(1.0))
          //                     //                       .margin(const EdgeInsets
          //                     //                           .symmetric(horizontal: 4))
          //                     //                       .make()
          //                     //                       .onTap(() {
          //                     //                     VxToast.show(context,
          //                     //                         msg:
          //                     //                             "couleur à l'index $index cliquée ");
          //                     //                     controller
          //                     //                         .changeColorIndex(index);
          //                     //                   }),
          //                     //                   Visibility(
          //                     //                       visible: index ==
          //                     //                           controller
          //                     //                               .colorIndex.value,
          //                     //                       child: const Icon(
          //                     //                         Icons.done,
          //                     //                         color: Colors.white,
          //                     //                       )),
          //                     //                 ],
          //                     //               )),
          //                     //     ),
          //                     //   ],
          //                     // ).box.padding(const EdgeInsets.all(8)).make(),
          //                     // Row(
          //                     //   children: [
          //                     //     SizedBox(
          //                     //       width: 100,
          //                     //       child: "Quantity: "
          //                     //           .text
          //                     //           .bold
          //                     //           .color(darkFontGrey)
          //                     //           .make(),
          //                     //     ),
          //                     //     Obx(
          //                     //       () => Row(
          //                     //         children: [
          //                     //           IconButton(
          //                     //               onPressed: () {
          //                     //                 controller.decreaseQuantity();
          //                     //                 controller.calculateTotalPrice(
          //                     //                     int.parse(data['p_price']));
          //                     //               },
          //                     //               icon: const Icon(Icons.remove)),
          //                     //           controller.quantity.value.text
          //                     //               .size(16)
          //                     //               .color(darkFontGrey)
          //                     //               .fontFamily(bold)
          //                     //               .make(),
          //                     //           IconButton(
          //                     //               onPressed: () {
          //                     //                 controller.increaseQuantity(
          //                     //                     int.parse(data['p_quantity']));
          //                     //                 controller.calculateTotalPrice(
          //                     //                     int.parse(data['p_price']));
          //                     //               },
          //                     //               icon: const Icon(Icons.add)),
          //                     //           "(${data['p_quantity']} available)"
          //                     //               .text
          //                     //               .size(16)
          //                     //               .color(textfieldGrey)
          //                     //               .make(),
          //                     //         ],
          //                     //       ),
          //                     //     ),
          //                     //   ],
          //                     // ).box.padding(const EdgeInsets.all(8)).make(),
          //                     Row(
          //                       children: [
          //                         SizedBox(
          //                           width: 100,
          //                           child: "Total: "
          //                               .text
          //                               .bold
          //                               .color(darkFontGrey)
          //                               .make(),
          //                         ),
          //                         "${controller.totalPrice.value}"
          //                             .numCurrency
          //                             .text
          //                             .size(16)
          //                             .color(redColor)
          //                             .fontFamily(bold)
          //                             .make(),
          //                       ],
          //                     ).box.padding(const EdgeInsets.all(8)).make(),
          //                   ],
          //                 ).box.white.shadowSm.make(),
          //               ),
          //               10.heightBox,
          //               "Description"
          //                   .text
          //                   .bold
          //                   .color(darkFontGrey)
          //                   .fontFamily(bold)
          //                   .make(),
          //               10.heightBox,
          //               "${data['p_desc']}".text.color(darkFontGrey).fontFamily(bold).make(),
          //               10.heightBox,
          //               // ListView(
          //               //   physics: const NeverScrollableScrollPhysics(),
          //               //   shrinkWrap: true,
          //               //   children: List.generate(
          //               //       itemDetailButtonsList.length,
          //               //       (index) => ListTile(
          //               //             title: itemDetailButtonsList[index]
          //               //                 .text
          //               //                 .fontFamily(semibold)
          //               //                 .color(darkFontGrey)
          //               //                 .make(),
          //               //             trailing: const Icon(Icons.arrow_forward),
          //               //           )),
          //               // ),
          //               // 20.heightBox,
          //               productsyoumaylike.text.bold
          //                   .fontFamily(bold)
          //                   .size(16)
          //                   .color(darkFontGrey)
          //                   .make(),
          //               10.heightBox,
          //               // StreamBuilder(
          //               // stream: FirestoreServices.allProducts(),
          //               // builder: (BuildContext context,
          //               //     AsyncSnapshot<QuerySnapshot> snapshot) {
          //               //   if (!snapshot.hasData) {
          //               //     return loadingIndicator();
          //               //   } else {
          //               //     var allproductsdata = snapshot.data!.docs;
          //               //     return GridView.builder(
          //               //       physics: const NeverScrollableScrollPhysics(),
          //               //       shrinkWrap: true,
          //               //       itemCount: allproductsdata.length,
          //               //       gridDelegate:
          //               //           const SliverGridDelegateWithFixedCrossAxisCount(
          //               //               crossAxisCount: 2,
          //               //               mainAxisSpacing: 8,
          //               //               crossAxisSpacing: 8,
          //               //               mainAxisExtent: 300),
          //               //       itemBuilder: (context, index) {
          //               //         return Column(
          //               //           crossAxisAlignment: CrossAxisAlignment.start,
          //               //           children: [
          //               //             Image.network(
          //               //               allproductsdata[index]['p_imgs'][0],
          //               //               width: 200,
          //               //               height: 200,
          //               //               fit: BoxFit.cover,
          //               //             ),
          //               //             const Spacer(),
          //               //             "${allproductsdata[index]['p_name']}"
          //               //                 .text
          //               //                 .fontFamily(semibold)
          //               //                 .color(darkFontGrey)
          //               //                 .make(),
          //               //             10.heightBox,
          //               //             "${allproductsdata[index]['p_price']} Fcfa"
          //               //                 .text
          //               //                 .color(redColor)
          //               //                 .fontFamily(bold)
          //               //                 .size(16)
          //               //                 .make()
          //               //           ],
          //               //         )
          //               //             .box
          //               //             .white
          //               //             .margin(
          //               //                 const EdgeInsets.symmetric(horizontal: 4))
          //               //             .roundedSM
          //               //             .padding(const EdgeInsets.all(12))
          //               //             .make()
          //               //             .onTap(() {
          //               //           Get.to(() => ItemDetails(
          //               //                 title:
          //               //                     "${allproductsdata[index]['p_name']}",
          //               //                 data: allproductsdata[index],
          //               //               ));
          //               //         });
          //               //       },
          //               //     );
          //               //   }
          //               // }),
          //               StreamBuilder(
          //                 stream: FirestoreServices.getProducts(data['p_category']),
          //                 builder: (BuildContext context,
          //                   AsyncSnapshot<QuerySnapshot> snapshot) {
          //                     if (!snapshot.hasData) {
          //                   return loadingIndicator();
          //                 } else {
          //                    var productsdata = snapshot.data!.docs;
          //                   return SingleChildScrollView(
          //                     scrollDirection: Axis.horizontal,
          //                     child: Row(
          //                       children: List.generate(
          //                           productsdata.length,
          //                           (index) => Column(
          //                                 children: [
          //                                   Image.network(
          //                                     productsdata[index]['p_imgs'][0],
          //                                     width: 150,
          //                                     fit: BoxFit.cover,
          //                                   ),
          //                                   10.heightBox,
          //                                   "${productsdata[index]['p_name']}"
          //                                       .text
          //                                       .fontFamily(semibold)
          //                                       .color(darkFontGrey)
          //                                       .make(),
          //                                   10.heightBox,
          //                                   "${productsdata[index]['p_name']} Fcfa"
          //                                       .text
          //                                       .color(redColor)
          //                                       .fontFamily(bold)
          //                                       .size(16)
          //                                       .make()
          //                                 ],
          //                               )
          //                                   .box
          //                                   .white
          //                                   .margin(const EdgeInsets.symmetric(
          //                                       horizontal: 4))
          //                                   .roundedSM
          //                                   .padding(const EdgeInsets.all(8))
          //                                   .make()),
          //                     ),
          //                   );}
          //                 }
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //         width: double.infinity,
          //         height: 60,
          //         child: validButton(
          //             color: redColor,
          //             onPress: () {
          //               // if (controller.quantity.value > 0) {
          //                 cartController.vendorID = data['vendor_id'];
          //                 controller.addToCart(
          //                     context: context,
          //                     vendorID: data['vendor_id'],
          //                     // color: data['p_colors'][controller.colorIndex.value],
          //                     img: data['p_imgs'][0],
          //                     qty: controller.quantity.value,
          //                     sellername: data['p_seller'],
          //                     title: data['p_name'],
          //                     tprice: controller.totalPrice.value);
          //                 VxToast.show(context, msg: "Ajouté au panier");
          //               // } else {
          //               //   VxToast.show(context,
          //               //       msg: "You must have one product on your cart");
          //               // }
          //             },
          //             textColor: whiteColor,
          //             title: "Ajouter au panier"),
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
