import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwa/consts/consts.dart';
import 'package:kikwa/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:kikwa/views/cart_screen/cart_screen.dart';

import '../../consts/lists.dart';
import '../../controllers/auth_controller.dart';
import '../../orders_screen/orders_screen.dart';
import '../../services/firestore_services.dart';
import '../../widgets_common/loading_indicattor.dart';
import '../auth_screen/login_screen.dart';
import '../wishlist_screen/wishlist_screen.dart';
import 'components/detail_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    //       }
    return 
      Scaffold(
        backgroundColor: Colors.indigo[400],
          body:
           StreamBuilder(
              stream: FirestoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                   AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return loadingIndicator();
                } else {
                  var data = snapshot.data!.docs[0];

                  return SafeArea(
                    child: Column(
                      children: [
                        //edit details button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.edit,
                              color: whiteColor,
                            ),
                          ).onTap(() {
                            Get.to(() =>
                                EditProfileScreen(
                                  data: data,
                                ));
                          }),
                        ),

                        //users details section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == ''
                                  ? Image
                                  .asset(
                                imgProfile2,
                                width: 50,
                                fit: BoxFit.cover,
                              )
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make()
                                  : Image
                                  .network(
                                data['imageUrl'],
                                width: 83,
                                fit: BoxFit.cover,
                              )
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      "${data['name']}".text
                                          .fontFamily(semibold)
                                          .white
                                          .make(),
                                      "${data['email']}".text.white.make()
                                    ],
                                  )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side:
                                      const BorderSide(color: whiteColor)),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: logout.text
                                      .fontFamily(semibold)
                                      .white
                                      .make()),
                            ],
                          ),
                        ),
                        20.heightBox,
                        FutureBuilder(
                            future: FirestoreServices.getCounts(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return loadingIndicator();
                              } else {
                                var countData = snapshot.data;
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCard(
                                      count: countData[0].toString(),
                                      title: "Panier",
                                      width: context.screenWidth / 3.4,
                                    ),
                                    detailsCard(
                                      count: countData[1].toString(),
                                      title: "Favoris",
                                      width: context.screenWidth / 3.4,
                                    ),
                                    detailsCard(
                                      count: countData[2].toString(),
                                      title: "Reservations",
                                      width: context.screenWidth / 3.4,
                                    ),
                                  ],
                                ).box.height(100).make();
                              }
                            }),

                        //buttons section

                        ListView
                            .separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileButtonsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => const OrdersScreen());
                                    break;
                                  case 1:
                                    Get.to(() => const WishlistScreen());
                                    break;
                                  case 2:
                                    Get.to(() => const CartScreen());
                                    break;
                                }
                              },
                              leading: Image.asset(
                                profileButtonsIcon[index],
                                width: 22,
                              ),
                              title: profileButtonsList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          },
                        )
                            .box
                            .white
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                            .box
                            // .color(redColor)
                            .make(),
                      ],
                    ),
                  );
                }
              }));
  }
}
