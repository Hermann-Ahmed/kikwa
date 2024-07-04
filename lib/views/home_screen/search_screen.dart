import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/widgets_common/loading_indicattor.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';
import '../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
        leading: Icon(Icons.arrow_back_ios).onTap(()=>Get.back()),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else if (snapshot.data!.docs.isEmpty) {
              return "Produit non trouvé".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 300),
                  children: filtered
                      .mapIndexed((currentValue, index) => Column(
                            children: [
                              Image.network(
                                filtered[index]['p_imgs'][0],
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              "${filtered[index]['p_name']}"
                                  .text
                                  .bold
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.blue, size: 18,),
                                  "${filtered[index]['p_area']}, "
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                                  "${filtered[index]['p_city']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                                ],
                              ),
                              10.heightBox,
                              "${filtered[index]['p_price']} Fcfa"
                                  .text
                                  .color(redColor)
                                  .bold
                                  .size(16)
                                  .make()
                            ],
                          )
                              .box
                              .white
                              .outerShadowMd
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .padding(const EdgeInsets.all(8))
                              .make()
                              .onTap(() {
                            Get.to(() => ItemDetails(
                                  title: "${filtered[index]['p_name']}",
                                  data: filtered[index],
                                ));
                          }))
                      .toList(),
                ),
              );
            }
          }),
    );
  }
}
