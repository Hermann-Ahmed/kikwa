import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/consts/lists.dart';
import 'package:kikwa/controllers/home_controller.dart';
import 'package:kikwa/controllers/product_controller.dart';
import 'package:kikwa/services/firestore_services.dart';
import 'package:kikwa/views/category_screen/item_details.dart';
import 'package:kikwa/views/home_screen/search_screen.dart';
import 'package:get/get.dart';

import '../../widgets_common/loading_indicattor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   "Emplacement".text.size(20).color(Colors.black54).make(),
                    5.heightBox,
                    Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue.shade700,),
                      Get.find<HomeController>().usercity == "" ? "N'Djamena, ".text.make() : Get.find<HomeController>().usercity.text.size(20).bold.color(Colors.black54).make(),
                      ", ".text.make(),
                      Get.find<HomeController>().usercountrry == "" ? "Tchad".text.make() : Get.find<HomeController>().usercountrry.text.size(20).bold.color(Colors.black54).make(),
                      ],
                        ),
                        ],
                        ),
                        Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Get.find<HomeController>().userimage == "" ? const Icon(Icons.person, size: 50,) : Image
                                  .network(
                                Get.find<HomeController>().userimage,
                                width: 83,
                                fit: BoxFit.cover,
                              )
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                    ),
            ],
          ),
          10.heightBox,
          // Container(
          //         height: 50,
          //         width: MediaQuery.of(context).size.width,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(5)
          //         ),
          //         child: TextFormField(
          //           decoration: InputDecoration(
          //             prefixIcon: Icon(Icons.search),
          //             border: InputBorder.none,
          //             label: "Rechercher".text.make(),
          //             suffixIcon: Container(
          //               margin: EdgeInsets.all(5),
          //               height: 40,
          //               width: 40,
          //               decoration: BoxDecoration(
          //                 color: Colors.indigo,
          //                 borderRadius: BorderRadius.circular(5)
          //               ),
          //               child: Center(
          //                 child: Icon(Icons.filter_list_sharp, color: Colors.white,)
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: const TextStyle(color: textfieldGrey)),
            ),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //swipers brands
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: slidersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 10))
                            .make(),
                      );
                    },
                  ),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Trouvons votre future maison ".text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  10.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    // decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // featuredProduct.text.white
                        //     .fontFamily(bold)
                        //     .size(18)
                        //     .make(),
                        // 10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder(
                              stream: FirestoreServices.getProducts("Résidence"),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return loadingIndicator();
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "Aucun produit trouvé !"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Image.network(
                                                      featuredData[index]['p_imgs']
                                                          [0],
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ),
                                                10.heightBox,
                                                "${featuredData[index]['p_name']}"
                                                    .text
                                                    .bold
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                Row(
                                                  children: [
                                                    const Icon(Icons.location_on, color: Colors.blue,),
                                                    "${featuredData[index]['p_area']}, "
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                    "${featuredData[index]['p_city']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    "${featuredData[index]['p_price']} Fcfa"
                                                        .text
                                                        .color(redColor)
                                                        .bold
                                                        .size(16)
                                                        .make(),
                                                        10.widthBox,
                                                        Icon(Icons.favorite, color: redColor, size: 25,).box.color(lightGrey).roundedFull.padding(EdgeInsets.all(5)).make()
                                                  ],
                                                )
                                              ],
                                            )
                                                .box
                                                .white
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .roundedSM
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                    title:
                                                        "${featuredData[index]['p_name']}",
                                                    data: featuredData[index],
                                                  ));
                                            })),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Vos locaux commerciaux ".text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  10.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    // decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // featuredProduct.text.white
                        //     .fontFamily(bold)
                        //     .size(18)
                        //     .make(),
                        // 10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder(
                              stream: FirestoreServices.getProducts("Commercial"),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return loadingIndicator();
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "Aucun produit trouvé".text.black.make();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                              children: [
                                                Image.network(
                                                  featuredData[index]['p_imgs']
                                                      [0],
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                "${featuredData[index]['p_name']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                Row(
                                                  children: [
                                                    const Icon(Icons.location_on, color: Colors.blue,),
                                                    "${featuredData[index]['p_area']}, "
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                    "${featuredData[index]['p_city']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    "${featuredData[index]['p_price']} Fcfa"
                                                        .text
                                                        .color(redColor)
                                                        .bold
                                                        .size(16)
                                                        .make(),
                                                        10.widthBox,
                                                        Icon(Icons.favorite, color: redColor, size: 25,).box.color(lightGrey).roundedFull.padding(EdgeInsets.all(5)).make()
                                                  ],
                                                )
                                              ],
                                            )
                                                .box
                                                .white
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .roundedSM
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                    title:
                                                        "${featuredData[index]['p_name']}",
                                                    data: featuredData[index],
                                                  ));
                                            })),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  20.heightBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: List.generate(
                  //       2,
                  //       (index) => homeButtons(
                  //           height: context.screenHeight * 0.15,
                  //           width: context.screenWidth / 2.5,
                  //           icon: index == 0 ? icTodaysDeal : icFlashDeal,
                  //           title: index == 0 ? todayDeal : flashsale)),
                  // ),
                  // second sliders
                  10.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: slidersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 10))
                            .make(),
                      );
                    },
                  ),
                  // category buttons
                  // 10.heightBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: List.generate(
                  //       3,
                  //       (index) => homeButtons(
                  //           height: context.screenHeight * 0.15,
                  //           width: context.screenWidth / 3.5,
                  //           icon: index == 0
                  //               ? icTopCategories
                  //               : index == 1
                  //                   ? icBrands
                  //                   : icTopSeller,
                  //           title: index == 0
                  //               ? topCategories
                  //               : index == 1
                  //                   ? brand
                  //                   : topSellers)),
                  // ),
                  //featured categories
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  // 20.heightBox,
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: List.generate(
                  //         3,
                  //         (index) => Column(
                  //               children: [
                  //                 featuredButton(
                  //                     icon: featuredImages1[index],
                  //                     title: featuredTitles1[index]),
                  //                 10.heightBox,
                  //                 featuredButton(
                  //                     icon: featuredImages2[index],
                  //                     title: featuredTitles2[index])
                  //               ],
                  //             )),
                  //   ),
                  // ),

                  //featured product
                  // 20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    // decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // featuredProduct.text.white
                        //     .fontFamily(bold)
                        //     .size(18)
                        //     .make(),
                        // 10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return loadingIndicator();
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "Aucun produit trouvé".text.black.make();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                              children: [
                                                Image.network(
                                                  featuredData[index]['p_imgs']
                                                      [0],
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                "${featuredData[index]['p_name']}"
                                                    .text
                                                    .bold
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on, color: Colors.blue,),
                                                    "${featuredData[index]['p_area']}, "
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                    "${featuredData[index]['p_city']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                  ],
                                                ),
                                                10.heightBox,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    "${featuredData[index]['p_price']} Fcfa"
                                                        .text
                                                        .color(redColor)
                                                        .bold
                                                        .size(16)
                                                        .make(),
                                                        10.widthBox,
                                                        Icon(Icons.favorite, color: redColor, size: 25,).box.color(lightGrey).roundedFull.padding(EdgeInsets.all(5)).make()
                                                  ],
                                                )
                                              ],
                                            )
                                                .box
                                                .white
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .roundedSM
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                    title:
                                                        "${featuredData[index]['p_name']}",
                                                    data: featuredData[index],
                                                  ));
                                            })),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),

                  //third swiper
                  20.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 150,
                    itemCount: slidersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 10))
                            .make(),
                      );
                    },
                  ),

                  //all products section
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Tous les produits"
                        .text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    // decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // featuredProduct.text.white
                        //     .fontFamily(bold)
                        //     .size(18)
                        //     .make(),
                        // 10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder(
                              stream: FirestoreServices.allProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return loadingIndicator();
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "Aucun produit trouvé".text.black.make();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                              children: [
                                                Image.network(
                                                  featuredData[index]['p_imgs']
                                                      [0],
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                "${featuredData[index]['p_name']}"
                                                    .text
                                                    .bold
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on, color: Colors.blue,),
                                                    "${featuredData[index]['p_area']}, "
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                    "${featuredData[index]['p_city']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                  ],
                                                ),
                                                10.heightBox,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    "${featuredData[index]['p_price']} Fcfa"
                                                        .text
                                                        .color(redColor)
                                                        .bold
                                                        .size(16)
                                                        .make(),
                                                        10.widthBox,
                                                        Icon(Icons.favorite, color: redColor, size: 25,).box.color(lightGrey).roundedFull.padding(EdgeInsets.all(5)).make()
                                                  ],
                                                )
                                              ],
                                            )
                                                .box
                                                .white
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .roundedSM
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                    title:
                                                        "${featuredData[index]['p_name']}",
                                                    data: featuredData[index],
                                                  ));
                                            })),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
