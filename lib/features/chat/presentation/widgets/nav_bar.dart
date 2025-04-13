import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/images.dart';
import '../bloc/home_bloc/home_bloc.dart';
import 'nav_button.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.sizeOf(context);
    // print("pageController = ${context.read<HomeBloc>().pageController.page}");
    return Container(
        width: size.width,
        height: 100,
        padding:
            const EdgeInsets.only(top: 10, bottom: 20, left: 11, right: 11),
        decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x0F0D0A2C),
                  offset: Offset(0, -4),
                  blurRadius: 20),
            ]),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            // print(
            //     "pageController = ${context.read<HomeBloc>().pageController.page}");
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavButton(
                  index: 0,
                  title: 'Chats',
                  svgUrl: AppSVG.chat,
                  enable: 
                  context.read<HomeBloc>().selectedPage == 0,
                  // (context.read<HomeBloc>().pageController.page ?? 0) < 1,
                ),
                NavButton(
                  index: 1,
                  title: 'Groups',
                  svgUrl: AppSVG.users,
                  enable: 
                  context.read<HomeBloc>().selectedPage == 1,
                  // (context.read<HomeBloc>().pageController.page ?? 0) <
                  //         2 &&
                  //     (context.read<HomeBloc>().pageController.page ?? 0) >= 1,
                ),
                NavButton(
                  index: 2,
                  title: 'Profile',
                  svgUrl: AppSVG.profile,
                  enable: 
                  context.read<HomeBloc>().selectedPage == 2,
                  // (context.read<HomeBloc>().pageController.page ?? 0) <
                  //         3 &&
                  //     (context.read<HomeBloc>().pageController.page ?? 0) >= 2,
                ),
                NavButton(
                  index: 3,
                  title: 'More',
                  svgUrl: AppSVG.more,
                  enable: 
                  context.read<HomeBloc>().selectedPage == 3,
                  // (context.read<HomeBloc>().pageController.page ?? 0) <
                  //         4 &&
                  //     (context.read<HomeBloc>().pageController.page ?? 0) >=3 ,
                ),
              ],
            );
          },
        ));
  }
}
