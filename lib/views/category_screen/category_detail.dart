import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/consts/lists.dart';
import 'package:kikwa/services/firestore_services.dart';
import 'package:kikwa/views/category_screen/item_details.dart';
import 'package:kikwa/widgets_common/loading_indicattor.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textfieldGrey,
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).white.make(),
        leading: const Icon(Icons.arrow_back_ios, color: whiteColor,).onTap(() => Get.back(),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  controller.subcat.length,
                  (index) => "${controller.subcat[index]}"
                          .text
                          .size(12)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .white
                          .rounded
                          .size(120, 60)
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .make()
                          .onTap(() {
                        switchCategory("${controller.subcat[index]}");
                        setState(() {});
                      })),
            ),
          ),
          20.heightBox,
          StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(child: loadingIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: 'Aucun produit trouvé !'.text.black.makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return

                      // items container

                      Expanded(
                          child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 300,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            data[index]['p_imgs'][0],
                            width: 200,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          "${data[index]['p_name']}"
                              .text
                              .bold
                              .color(darkFontGrey)
                              .make(),
                          10.heightBox,
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.blue, size: 18,),
                               "${data[index]['p_area']} "
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                              "${data[index]['p_city']}"
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
                                "${data[index]['p_price']} Fcfa"
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
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .roundedSM
                          .shadowSm
                          .padding(const EdgeInsets.all(12))
                          .make()
                          .onTap(() {
                        controller.getSubCategories(categoriresList[index]);
                        controller.checkIfFav(data[index]);
                        Get.to(() => ItemDetails(
                              title: "${data[index]['p_name']}",
                              data: data[index],
                            ));
                      });
                    },
                  ));
                }
              }),
        ],
      ),
    );
  }
}
