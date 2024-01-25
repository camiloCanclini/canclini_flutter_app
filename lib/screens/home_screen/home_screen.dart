import 'package:SuperStore/screens/home_screen/widgets/categories_list.dart';
import 'package:SuperStore/screens/home_screen/widgets/credit_cards_carousel.dart';
import 'package:SuperStore/screens/home_screen/widgets/offers_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    ThemeModel appTheme = Provider.of<ThemeProvider>(context).themeModel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OffersCarouselWidget(),

        Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: CreditCardsCarouselWidget(),
            )
        ),
        SizedBox(
          width: double.infinity,
          height: 80,
          child: CategoryListWidget(),
        ),
      ],
    );
  }
}
