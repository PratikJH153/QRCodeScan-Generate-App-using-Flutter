import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Option {
  final String title;
  final IconData icon;

  Option({
    required this.title,
    required this.icon,
  });

  static List<Option> options = [
    Option(
      title: "Text",
      icon: Icons.text_fields,
    ),
    Option(
      title: "URL",
      icon: CupertinoIcons.link,
    ),
    Option(
      title: "Phone",
      icon: CupertinoIcons.phone,
    ),
    Option(
      title: "Email",
      icon: CupertinoIcons.mail,
    ),
    Option(
      title: "Location",
      icon: CupertinoIcons.location,
    ),
  ];
}
