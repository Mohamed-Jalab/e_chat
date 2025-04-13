import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/images.dart';
import '../bloc/home_bloc/home_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    right: 24.0, left: 24.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: context.read<HomeBloc>().isSearchOpened ? 0 : 1,
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: const Row(
                        children: [
                          Image(
                              image: AssetImage(AppImages.logoEChatColored),
                              width: 32,
                              height: 32),
                          SizedBox(width: 12),
                          Text('E-Chat',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                              ))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity:
                              context.read<HomeBloc>().isSearchOpened ? 0 : 1,
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: GestureDetector(
                            onTap: () {
                              print("onTap search");
                              context.read<HomeBloc>().add(SearchEvent());
                            },
                            child: SvgPicture.asset(AppSVG.search,
                                height: 24, width: 24),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            print("onTap plus");
                            if (!context.read<HomeBloc>().isSearchOpened) {
                              context.read<HomeBloc>().add(MenuEvent());
                            } else {
                              context.read<HomeBloc>().add(SearchEvent());
                            }
                          },
                          child: AnimatedContainer(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(202)),
                                color: context.read<HomeBloc>().isMenuOpened ||
                                        context.read<HomeBloc>().isSearchOpened
                                    ? const Color(0x33FFFFFF)
                                    : const Color(0x00FFFFFF)),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: AnimatedRotation(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.elasticOut,
                              turns: context.read<HomeBloc>().isMenuOpened ||
                                      context.read<HomeBloc>().isSearchOpened
                                  ? (45 + 90) / 360
                                  : 0,
                              child: SvgPicture.asset(AppSVG.plus,
                                  width: 36, height: 36),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
