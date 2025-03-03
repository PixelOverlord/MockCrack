import 'package:flutter/material.dart';

Widget authTile({
  required String label,
  required String hintText,
  required IconData icon,
  required BuildContext ctx,
  required TextEditingController controller,
}) {
  final mq = MediaQuery.of(ctx).size;

  return Container(
    height: mq.height * 0.07,
    width: double.infinity,
    margin: EdgeInsets.only(bottom: mq.height * 0.01),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color(0xffc2c2c2),
          spreadRadius: 1,
          blurRadius: 1,
        )
      ],
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Icon(
            icon,
            color: Colors.green,
            size: 35,
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              label: Text(label),
              hintText: hintText,
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
