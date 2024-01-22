//import 'package:cached_network_image/cached_network_image.dart';
// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final bool hasBorder;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 27.0,
          backgroundColor: Colors.black.withOpacity(.79),
          child: CircleAvatar(
            radius: 25,

            backgroundColor: Colors.blueGrey[50],
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
    );
  }
}
