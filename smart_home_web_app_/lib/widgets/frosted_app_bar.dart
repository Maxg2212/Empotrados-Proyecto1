import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;

  const FrostedAppBar({
    super.key,
    required this.title,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea( // prevents overlapping status bar
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: preferredSize.height,
            decoration: BoxDecoration(
              color: const Color(0xFF7D7F7D).withOpacity(0.4),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: AppBar(
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: centerTitle,
              backgroundColor: Colors.transparent, // 👈 no solid color
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
