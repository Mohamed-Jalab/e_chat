import 'package:flutter/material.dart';

import '../../../../core/images.dart';

class Contact extends StatelessWidget {
  const Contact({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      highlightColor: const Color(0xFFF0F0F3),
      child: Padding(
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
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
                        Text(
                          '10:25',
                          style: TextStyle(
                              color: Color(0xFF686A8A),
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Thanks a bunch! Have a great day! 😊",
                            style: TextStyle(
                                color: Color(0xFF9A9BB1),
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                        //TODO
                        true
                            ? const SizedBox()
                            : Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFF40C4FF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 1),
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
