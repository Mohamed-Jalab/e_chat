import 'dart:async';

import 'package:chat_app/features/chat/presentation/widgets/chats_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/home_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    Timer? timer;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: PageView(
          onPageChanged: (value) {
            //! this is important to sync [PageView] and [NavBar]
            timer?.cancel();
            timer = Timer.periodic(const Duration(milliseconds: 100), (time) {
              print("timer");
              context.read<HomeBloc>().add(ChangePageEvent(index: value));
              timer?.cancel();
            });
          },
          controller: context.read<HomeBloc>().pageController,
          children: [
            const ChatsBody(),
            Container(
                width: size.width, height: size.height, color: Colors.red),
            Container(
                width: size.width, height: size.height, color: Colors.green),
            Container(
                width: size.width, height: size.height, color: Colors.blue),
          ]),
    );
  }
}
