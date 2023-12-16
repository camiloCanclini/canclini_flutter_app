import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/user_profile_screen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  MyAppBar({super.key,  required this.titleAppBar});

  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(titleAppBar),
      actions: [
        SizedBox(
          width: 50,
          height: 50,
          child: IconButton(
            icon: const Icon(Icons.account_circle),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfileScreen()),
              );
            },

          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}