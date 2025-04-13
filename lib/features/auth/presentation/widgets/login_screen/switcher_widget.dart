import 'package:flutter/material.dart';

class SwitcherWidget extends StatelessWidget {
  const SwitcherWidget({
    super.key,
    this.showFirst = true,
    required this.firstChild,
    required this.secondChild,
  });
  final bool showFirst;
  final Widget firstChild;
  final Widget secondChild;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.fastLinearToSlowEaseIn,
      switchOutCurve: Curves.fastLinearToSlowEaseIn.flipped,
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: showFirst ? firstChild : secondChild,
    );

    // return AnimatedCrossFade(
    //   alignment: Alignment.centerLeft,
    //   firstChild: const Text("Login",
    //       style: TextStyle(
    //         fontSize: 35,
    //         fontWeight: FontWeight.w700,
    //         color: Colors.white,
    //         letterSpacing: .05,
    //       )),
    //   secondChild:
    //        const CustomTextButton(title: 'Register'),
    //       // const Text("Register",
    //       //     style: TextStyle(
    //       //       fontSize: 35,
    //       //       fontWeight: FontWeight.w700,
    //       //       color: Colors.white,
    //       //       letterSpacing: .05,
    //       //     )),
    //   crossFadeState:
    //       showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    //   duration: const Duration(milliseconds: 500),
    //   // sizeCurve: Curves.linear,
    //   firstCurve: Curves.fastLinearToSlowEaseIn,
    //   secondCurve: Curves.fastLinearToSlowEaseIn,
    // );
  }
}
