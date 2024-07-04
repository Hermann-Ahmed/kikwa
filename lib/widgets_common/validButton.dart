
import 'package:kikwa/consts/consts.dart';

Widget validButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12),
          //  foregroundColor: color,
           backgroundColor: color
           ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
