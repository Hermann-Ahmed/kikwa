import 'package:kikwa/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    getUserimg();
    getUsercity();
    getUsercountry();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = '';
   var userimage = "";
  var usercountrry= '';
  var usercity= "";

  var searchController = TextEditingController();

  getUsername() async {
    var name = await firestore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get()
        .then((value) {
       if(value.docs.isNotEmpty) {
         return value.docs.single['name'];
       }
    });

    username = name;
  }

   getUserimg() async {
    var img = await firestore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get()
        .then((value) {
       if(value.docs.isNotEmpty) {
         return value.docs.single['imageUrl'];
       }
    });

    userimage = img;
  }

  getUsercity() async {
    var city = await firestore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get()
        .then((value) {
       if(value.docs.isNotEmpty) {
         return value.docs.single['ville'];
       }
    });

    usercity = city;
  }

  getUsercountry() async {
    var country = await firestore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get()
        .then((value) {
       if(value.docs.isNotEmpty) {
         return value.docs.single['pays'];
       }
    });

    usercountrry = country;
  }
}
