import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwa/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';

class ProductController extends GetxController{
  var quantity = 0.obs;

  var colorIndex = 0.obs;

  var searchController = TextEditingController();

  var totalPrice = 0.obs;

  var subcat = [];

  var isFav = false.obs;

  getSubCategories(title) async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var collect = decoded.categories.where((element) => element.name == title).toList();

    for(var e in collect[0].subcategory){
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if(quantity.value < totalQuantity){
      quantity.value++;
    }
  }

  decreaseQuantity() {
   if(quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellername, tprice, context, vendorID}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'vendor_id': vendorID,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }, SetOptions(merge: true)).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
    isFav.value = false;
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([
        currentUser!.uid
      ])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Ajouté aux favoris");
  }

  removeToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([
        currentUser!.uid
      ])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Retiré des favoris");
  }

  checkIfFav(data) async {
    if(data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    }else{
      isFav(false);
    }
  }
}