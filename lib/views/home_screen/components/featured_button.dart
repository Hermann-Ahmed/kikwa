import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/views/category_screen/category_detail.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 40,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .rounded
      .outerShadow
      .make().onTap(() {
    Get.to(()=> CategoryDetails(title: title));
  });
}
