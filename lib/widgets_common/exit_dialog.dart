import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/widgets_common/validButton.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit ?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            validButton(color: redColor, onPress: (){SystemNavigator.pop();}, textColor: whiteColor, title: "Yes"),
            validButton(color: redColor, onPress: (){Navigator.pop(context);}, textColor: whiteColor, title: "No"),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}