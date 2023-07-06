import 'package:flutter/material.dart';

const Color secondaryColor = Color.fromARGB(255, 106, 27, 154);
const Color primaryColor = Color.fromARGB(255, 231, 220, 248);

class SubjectIconTile extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String subjectName;
  const SubjectIconTile({
    super.key,
    required this.onTap,
    required this.iconPath,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(29),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset.fromDirection(1, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/subject_icons/$iconPath"),
                      fit: BoxFit.contain,
                      alignment: Alignment.center),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Text(
                subjectName.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
