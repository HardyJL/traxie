import 'package:flutter/material.dart';

class TraxieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TraxieAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size(double.infinity, kBottomNavigationBarHeight);
}
