import 'package:kikwa/consts/consts.dart';

Widget loadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.indigo),
    ),
  );
}