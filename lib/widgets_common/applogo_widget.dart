import 'package:kikwa/consts/consts.dart';

Widget applogoWidget() {
  return Image.asset(icLogoApp)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
