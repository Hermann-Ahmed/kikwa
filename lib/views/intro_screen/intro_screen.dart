import 'package:flutter/material.dart';
import 'package:kikwa/views/auth_screen/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                                  radius: 40,
                                  backgroundImage: AssetImage("assets/logo.png"),
                                ),
                      ),
                    ),
                  // Icon(CupertinoIcons.building_2_fill, color: Colors.blue, size: 50,),
                  20.widthBox,
                  'Bienvenue sur Kikwa App'.text.size(22).color(Colors.black).bold.make(),
                ],
              ),
              20.heightBox,
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/villa1.jpg", height: 465, width: double.infinity, fit: BoxFit.cover,),
              ),
              15.heightBox,
              "Trouvons l’endroit de vos rêves".text.bold.size(20).black.make(),
              15.heightBox,
              "Trouvez l’endroit de vos rêves en quelques clics".text.color(Colors.black45).size(14).fontWeight(FontWeight.w500).make(),
              Spacer(),
              
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Démarrer".text.bold.size(14).white.make(),
                      Icon(Icons.arrow_outward_outlined, color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}