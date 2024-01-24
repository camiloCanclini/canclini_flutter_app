import 'package:canclini_flutter_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.checkroom, 'text': 'Ropa'},
    {'icon': Icons.computer, 'text': 'Tecnología'},
    {'icon': Icons.diamond, 'text': 'Accesorios'},
    // Agrega más categorías según sea necesario
  ];

  CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        categories.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CategoryBadge(
            icon: categories[index]['icon'],
            text: categories[index]['text'],
          ),
        ),
      ),
    );
  }
}

class CategoryBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const CategoryBadge({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    ThemeModel appTheme = Provider.of<ThemeProvider>(context).themeModel;
    return Container(
      width: 180,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: appTheme.cardBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, color: appTheme.primaryTextColor),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(color: appTheme.primaryTextColor),
          ),
        ],
      ),
    );
  }
}
