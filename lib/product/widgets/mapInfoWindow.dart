import 'package:flutter/material.dart';
import 'package:kimyapar/core/base/avatar.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30))),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
            title: const Text("Eren Karaboğa"),
            trailing:const Icon(Icons.chevron_right),
            leading: ClipOval(
              child: Image.network(
                "https://res.cloudinary.com/dinqa9wqr/image/upload/v1658395937/eren_avocqf.jpg",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          )),
    );
  }
}
