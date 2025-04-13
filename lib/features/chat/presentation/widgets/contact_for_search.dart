import 'package:flutter/material.dart';

import '../../../../core/images.dart';

class ContactWithIcon extends StatelessWidget {
  const ContactWithIcon({super.key, required this.icon, this.onTap});
  final Widget icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
      child: SizedBox(
        //! in Figma must be 42 but 43.5 by seeing correct I don't know why (;_;) (;_;)
        height: 43.5,
        child: Row(
          children: [
            // FadeInImage(placeholder: AssetImage(''), image: NetworkImage(''))
            const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(42 / 2)),
              child: Image(
                image: AssetImage(AppImages.avatar1),
                fit: BoxFit.cover,
                width: 42,
                height: 42,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "David Wayne",
                    style: TextStyle(
                        color: Color(0xFF2C2D3A),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  Text("Thanks a bunch! Have a great day! 😊",
                      style: TextStyle(
                          color: Color(0xFF9A9BB1),
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                ],
              ),
            ),
            IconButton(icon: icon, onPressed: onTap),
          ],
        ),
      ),
    );
  }
}
