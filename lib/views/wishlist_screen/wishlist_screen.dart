import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kikwa/services/firestore_services.dart';

import '../../consts/consts.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios,).onTap(() => Get.back(),),
        title:
            "My Wishlists".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlists(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No wishlists yet !"
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.network(
                        "${data[index]['p_imgs'][0]}",
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      title: "${data[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                      subtitle: "${data[index]['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      trailing: const Icon(
                        Icons.favorite,
                        color: redColor,
                      ).onTap(() {
                        firestore.collection(productsCollection).doc(data[index].id).set(
                            {
                              'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                      }),
                    );
                  });
            }
          }),
    );
  }
}
