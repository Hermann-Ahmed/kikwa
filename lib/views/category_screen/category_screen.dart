import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/consts/lists.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import 'category_detail.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return 
      Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: categories.text.fontFamily(bold).black.make(),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: categoriresList.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 200,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoryImages[index],
                    fit: BoxFit.cover,
                    height: 120,
                    width: 200,
                  ),
                  10.heightBox,
                  categoriresList[index]
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make()
                ],
              )
                  .box
                  .white
                  .rounded
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .make()
                  .onTap(
                    (){
                    controller.getSubCategories(categoriresList[index] );
                    Get.to(
                    () => CategoryDetails(title: categoriresList[index]));
              }
                  );
            },
          ),
        ),
      );
  }
}
