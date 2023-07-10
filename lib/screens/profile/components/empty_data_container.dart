import 'package:flutter/material.dart';
import 'details_container.dart';

class EmptyDataContainer extends StatelessWidget {
  const EmptyDataContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: "profilePic",
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 75,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 35,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 23,
          width: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Column(
          children: [
            DetailsContainer(
              phoneNumber: "N.A.",
              date: "N.A.",
            ),
          ],
        ),
      ],
    );
  }
}
