import 'dart:developer';

import 'package:chat_app/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../../../injection.dart' as di;
import '../../../../core/constants.dart';
import '../../../../core/theme_bloc/theme_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../chat/presentation/screens/home_screen.dart';
import '../bloc/auth_bloc/bloc.dart';
import '../widgets/login_screen/auth_widget.dart';
import '../widgets/login_screen/clippers/simi_bottom_circle_clipper.dart';
import '../widgets/login_screen/custom_animated_align.dart';
import '../widgets/login_screen/custom_text_button.dart';
import '../widgets/login_screen/profile_image.dart';
import '../widgets/login_screen/switcher_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController1;
  late AnimationController animationController2;
  late CurvedAnimation curvedAnimation1;
  late CurvedAnimation curvedAnimation2;

  @override
  void initState() {
    super.initState();
    animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      value: 0,
      lowerBound: 0,
      upperBound: 1,
    );
    animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      value: 0,
      lowerBound: 0,
      upperBound: 1,
    );
    curvedAnimation1 = CurvedAnimation(
      parent: animationController1,
      curve: Curves.fastLinearToSlowEaseIn,
      //! I use [flipped] to be the (reverseCurve) like exactly (curve)
      reverseCurve: Curves.fastLinearToSlowEaseIn.flipped,
    );
    curvedAnimation2 = CurvedAnimation(
      parent: animationController2,
      curve: Curves.fastLinearToSlowEaseIn,
      //! I use [flipped] to be the (reverseCurve) like exactly (curve)
      reverseCurve: Curves.fastLinearToSlowEaseIn.flipped,
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController1.dispose();
    animationController2.dispose();
    curvedAnimation1.dispose();
    curvedAnimation2.dispose();
  }

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: BlocProvider(
          create: (context) => AuthBloc(),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              log("===========${state.toString()}==========");
              if (state is Success) {
                Navigator.of(context).pushReplacement(
                    SildRightPageRouteWithCustomAnimation(
                        page: const HomeScreen()));
              }
              if (state is Failure) {
                print(state.message);
                ToastContext().init(context);
                Toast.show(state.message, duration: Toast.lengthLong);
              }
            },
            builder: (context, state) {
              AuthBloc bloc = BlocProvider.of(context);
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  AnimatedBuilder(
                      animation:
                          bloc.isCircle ? curvedAnimation2 : curvedAnimation1,
                      builder: (context, child) {
                        return ClipPath(
                          clipper: keyboardSize > 100
                              ? null
                              : SimiBottomCircleClipper(
                                  value1: curvedAnimation1.value,
                                  circleClip: bloc.isCircle,
                                  value2: curvedAnimation2.value,
                                ),
                          child: Container(
                              height: keyboardSize > 100
                                  ? size.height * .43 - 75
                                  : size.height * .43,
                              width: size.width,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer),
                        );
                      }),
                  AnimatedBuilder(
                      animation:
                          bloc.isCircle ? curvedAnimation2 : curvedAnimation1,
                      builder: (context, child) {
                        return ClipPath(
                          clipper: keyboardSize > 100
                              ? null
                              : SimiBottomCircleClipper(
                                  value1: curvedAnimation1.value,
                                  circleClip: bloc.isCircle,
                                  value2: curvedAnimation2.value,
                                ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            alignment: Alignment.center,
                            height: keyboardSize > 100
                                ? size.height * .36 - 75
                                : size.height * .36,
                            width: size.width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                // Color(0xFF1bb2f6),
                                // Color(0xFF05aaf4),
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  const Spacer(flex: 2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SwitcherWidget(
                                        showFirst: isLogin,
                                        firstChild: Text("Login",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                        secondChild: CustomTextButton(
                                          foregroundColor: context
                                                  .read<ThemeBloc>()
                                                  .darkTheme
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .color
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .color,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                          onTap: () {
                                            bloc.add(ResetSettings());
                                            animationController1.reverse();
                                            animationController2.forward();
                                            setState(() {
                                              isLogin = !isLogin;
                                            });
                                          },
                                          title: 'Login',
                                          icon: Icons.arrow_back_rounded,
                                        ),
                                      ),
                                      SwitcherWidget(
                                          showFirst: isLogin,
                                          secondChild: Text("Register",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge),
                                          firstChild: CustomTextButton(
                                            foregroundColor: context
                                                    .read<ThemeBloc>()
                                                    .darkTheme
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .color
                                                : Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .color,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            onTap: () {
                                              bloc.add(ResetSettings());
                                              animationController1.forward();
                                              animationController2.forward();
                                              setState(() {
                                                isLogin = !isLogin;
                                              });
                                            },
                                            title: 'Register',
                                          )),
                                    ],
                                  ),
                                  const Spacer(flex: 1),
                                  CustomAnimatedAlign(isLogin: isLogin),
                                  // on keyboard is opening
                                  AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      height: keyboardSize > 100 ? 15 : 75),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    top: keyboardSize > 100
                        ? size.height * .49 - 75
                        : size.height * .49,
                    //* this [AnimationController] to just pass it to Bloc
                    //* to run animationController.reverse();
                    child: AuthWidget(
                        isLogin: isLogin,
                        animationController: animationController2),
                  ),
                  // bloc.isValidCode
                  if (!isLogin)
                    Positioned(
                      top: size.height * .14,
                      width: size.width,
                      child: ProfileImage(show: bloc.isValidCode),
                    ),
                  if (state is Loading) const LoadingWidget(),
                  // Positioned(
                  //     bottom: 0,
                  //     child: IconButton(
                  //         icon: const Icon(Icons.clear),
                  //         onPressed: () async {
                  //           // context
                  //           //     .read<ThemeBloc>()
                  //           //     .add(ChangeThemeEvent(darkTheme: true));
                  //           await di
                  //               .sl<SharedPreferences>()
                  //               .setBool(Constants.isOnboardVisited, false);
                  //         }))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
