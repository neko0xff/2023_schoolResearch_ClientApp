// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_print, must_be_immutable, camel_case_types
import 'package:flutter/material.dart';

class wallpaperLogin extends StatelessWidget {
  String wallpaper_path = "assets/images/wallpaper001.png";

  wallpaperLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      wallpaper_path,
      width: 1500.0,
      height: 500.0,
      fit: BoxFit.contain,
    );
  }
}
