import 'package:flutter/material.dart';

import '../../../../core/images.dart';
import 'contact.dart';

class ChatsBody extends StatelessWidget {
  const ChatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height,
      width: size.width,
      child: ListView.builder(
        padding: EdgeInsets.only(top: size.height * .129 + 20, bottom: 110),
        itemCount: 10,
        itemBuilder: (context, index) => Contact(imageUrl: images[index % 3]),
      ),
    );
  }
}

List<String> images = [AppImages.avatar1, AppImages.avatar2, AppImages.avatar3];
