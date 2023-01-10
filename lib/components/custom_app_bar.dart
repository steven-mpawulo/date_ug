import 'package:date_ug/screens/chats_screen.dart';
import 'package:date_ug/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;
  final double myAppBarHeight = 50.0;
  final bool hasBackButton;

  CustomAppBar({
    Key? key,
    required this.title,
    required this.hasActions,
    required this.hasBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: GoogleFonts.arsenal(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: hasActions
          ? [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatsScreen()));
                },
                icon: const Icon(
                  Icons.message_outlined,
                  color: Colors.black,
                  size: 35.0,
                ),
              ),
              const SizedBox(
                width: 9.0,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.black,
                  size: 35.0,
                ),
              ),
            ]
          : [],
      centerTitle: true,
      automaticallyImplyLeading: hasBackButton,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(myAppBarHeight);
}
