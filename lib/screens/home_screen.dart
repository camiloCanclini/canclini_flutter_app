import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            height: 200,
            decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(25),
              image: const DecorationImage(
                image: AssetImage('assets/images/home_screen/oferta_del_dia.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}