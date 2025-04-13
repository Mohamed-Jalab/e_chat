import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../widgets/adding_widget.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_body.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    // final double paddingBottom = MediaQuery.of(context).viewInsets.bottom;
    final double paddingBottom = MediaQuery.viewInsetsOf(context).bottom;
    // print(paddingBottom);
    // print("===home_screen.dart===");
    return BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            alignment: Alignment.center,
            children: [
              //! body
              const Positioned(top: 0, child: HomeBody()),
              //! appBar
              const Positioned(top: 0, child: AppBarForShadow()),
              const Positioned(top: 0, child: HomeAppBar()),
              //! navBar
              //  Positioned(bottom: 0 - paddingBottom, child: NavBar()),
              const Positioned(bottom: 0, child: NavBar()),
              Positioned(
                top: 0,
                right: 0,
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTapDown: (details) {
                          context.read<HomeBloc>().add(MenuEvent());
                        },
                        onTapUp: (details) {
                          context.read<HomeBloc>().add(MenuEvent());
                        },
                        onTap: () {
                          print('pop');
                          context.read<HomeBloc>().add(MenuEvent());
                        },
                        child: SizedBox(
                            width: context.read<HomeBloc>().isMenuOpened
                                ? size.width
                                : 0,
                            height: context.read<HomeBloc>().isMenuOpened
                                ? size.height
                                : 0));
                  },
                ),
              ),
              //! Searching section
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Positioned(
                    top: size.height * .129 - 60,
                    //this size is calc(padding + iconSize + additionalPadding)
                    right: 80,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear,
                      width: context.read<HomeBloc>().isSearchOpened
                          ? size.width - 104
                          : 0,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: TextField(
                        controller: context.read<HomeBloc>().searchController,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        // textAlign: TextAlign.center,
                        // textAlignVertical: TextAlignVertical.bottom,
                        decoration: const InputDecoration(
                            // fillColor: Colors.red,
                            // filled: true,
                            // enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide.none),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0x4C2C2D3A)),
                            contentPadding:
                                EdgeInsets.only(left: 24, right: 16)),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                  top: size.height * .1197,
                  right: size.width * .058524,
                  child: const AddingWidget()),
            ],
          ),
        ));
  }
}

class AppBarForShadow extends StatelessWidget {
  const AppBarForShadow({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height * .129,
      decoration: const BoxDecoration(color: Color(0xFF135CAF), boxShadow: [
        BoxShadow(
            color: Color(0x26000000), offset: Offset(0, 0), blurRadius: 20)
      ]),
    );
  }
}
