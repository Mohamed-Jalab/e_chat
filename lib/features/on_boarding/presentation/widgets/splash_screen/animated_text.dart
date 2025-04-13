import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
    required this.showText,
  });

  final bool showText;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      alignment: Alignment.centerRight,
      firstCurve: Curves.fastLinearToSlowEaseIn,
      secondCurve: Curves.fastLinearToSlowEaseIn,
      sizeCurve: Curves.easeIn,
      crossFadeState:
          showText ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 400),
      firstChild: const SizedBox(),
      secondChild: Text("   E-Chat",
          style: Theme.of(context).textTheme.displayLarge),
    );
  }  
}
