import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final List<Map<String, dynamic>> _menuItems = <Map<String,dynamic>>[
    {'route':'home','title':'Home','icon': Icons.home},
    {'route':'products','title':'Productos','icon': Icons.category},
    {'route':'config','title':'Configuración','icon': Icons.settings},
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(      
      child: ListView(        
        //padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 100,),
          ...ListTile.divideTiles(
            context: context,
            tiles: _menuItems.map(
              (item) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0, 
                      horizontal: 10
                    ),
                    dense: true,
                  minLeadingWidth: 25,                  
                  iconColor: Colors.blueGrey,
                  title: Text(item['title']!, style: const TextStyle(fontFamily: 'FuzzyBubbles')),
                  leading: Icon(item['icon'] ?? Icons.arrow_right_sharp),
                  onTap: () {
                    Navigator.pop(context);
                    //Navigator.pushReplacementNamed(context, item['route']!);
                    Navigator.pushNamed(context, item['route']!);
                  },
              )
            ).toList()
          )          
        ],
      ),
    );
  }
}