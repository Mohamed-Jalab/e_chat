import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height * .129,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
        gradient: LinearGradient(
          colors: [Color(0xFF135CAF), Color(0xFF3674BB)],
          // colors: [Colors.red, Colors.redAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          // stops: [5, 80]
          stops: [.75, 1],
        ),
      ),
      child: Stack(
        children: [
          const Column(
            children: [
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add Friend",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFFFFFF))),
                    ],
                  )),
            ],
          ),
          Positioned(
            bottom: 22,
            left: 24,
            child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(22)),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        width: 42,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color(0x19FFFFFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Color(0xFFF0F0F3))))),
          )
        ],
      ),
    );
  }
}
