import 'package:chat_app/features/chat/presentation/widgets/add_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/images.dart';
import '../../../../core/routes.dart';
import '../bloc/home_bloc/home_bloc.dart';

class AddingWidget extends StatelessWidget {
  const AddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastLinearToSlowEaseIn,
          height: context.read<HomeBloc>().isMenuOpened ? 160 : 0,
          width:
              context.read<HomeBloc>().isMenuOpened ? size.width * .83969 : 0,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [BoxShadow(blurRadius: 100, color: Color(0x33000000))],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomListTile(
                    svgUrl: AppSVG.user,
                    title: "Add Friend",
                    onTap: () {
                      context.read<HomeBloc>().add(MenuEvent());
                      Navigator.of(context).push(
                          SildRightPageRouteWithCustomAnimation(
                              page: const AddFriend()));
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomListTile(
                    svgUrl: AppSVG.users,
                    title: "Create Group",
                    onTap: () {
                      context.read<HomeBloc>().add(MenuEvent());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.svgUrl,
    this.onTap,
  });
  final String title;
  final String svgUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        splashColor: const Color(0xFFF0F0F3),
        highlightColor: const Color(0xFFF0F0F3),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            // 32 for parent's padding and 32 for its padding
            width: (size.width * .83969) - 64,
            child: Row(
              children: [
                SvgPicture.asset(svgUrl, width: 24, height: 24),
                const SizedBox(width: 16),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xFF2C2D3A)),
                  child: Text(title),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
