import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/home_bloc/home_bloc.dart';

class NavButton extends StatelessWidget {
  // final List<Color>? backgroundColors;
  final String title;
  final String svgUrl;
  final int index;
  final bool enable;

  const NavButton({
    super.key,
    // this.backgroundColors,
    required this.title,
    required this.svgUrl,
    required this.index,
    this.enable = false,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            highlightColor: const Color(0xFFF0F0F3),
            splashColor: const Color(0xFFF0F0F3),
            onTap: () {
              print(index);
              // context.read<HomeBloc>().pageController.animateToPage(index,
              //     duration: const Duration(milliseconds: 500),
              //     curve: Curves.easeInOut);
              context.read<HomeBloc>().add(ChangePageEvent(index: index));
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
                width: size.width * .19338,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    gradient: enable
                        ? const LinearGradient(
                            colors: [Color(0xFF40C4FF), Color(0xFF03A9F4)])
                        : null
                    // LinearGradient(
                    //     colors: backgroundColors ??
                    //         [Colors.transparent, Colors.transparent]),
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image(image: AssetImage(),)
                    // Icon(Icons.message, size: 24, color: foregroundColor),
                    SvgPicture.asset(svgUrl,
                        width: 24,
                        height: 24,
                        color: enable
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF9A9BB1)),
                    const SizedBox(height: 10),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastLinearToSlowEaseIn,
                      style: TextStyle(
                          color: enable
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF9A9BB1),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                      child: Text(title),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
