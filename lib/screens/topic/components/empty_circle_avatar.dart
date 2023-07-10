import 'package:flutter/material.dart';
import '../../profile/profile.dart';

class EmptyCircleAvatar extends StatelessWidget {
  const EmptyCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profilePic",
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProfileScreen.id);
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade300,
        ),
      ),
    );
  }
}
