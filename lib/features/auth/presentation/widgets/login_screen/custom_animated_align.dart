import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/bloc.dart';

class CustomAnimatedAlign extends StatelessWidget {
  const CustomAnimatedAlign({super.key, required this.isLogin});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        AuthBloc bloc = BlocProvider.of(context);
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn,
          opacity: bloc.isValidCode ? 0 : 1,
          child: AnimatedAlign(
            curve: Curves.fastLinearToSlowEaseIn,
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 400),
            child: Column(
              crossAxisAlignment:
                  isLogin ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                AnimatedCrossFade(
                  crossFadeState: bloc.isCodeReceived
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                  firstCurve: Curves.fastLinearToSlowEaseIn,
                  secondCurve: Curves.fastLinearToSlowEaseIn,
                  secondChild:  Text("Enter OTP Code",
                      style: Theme.of(context).textTheme.titleMedium),
                  firstChild: Text('Enter your',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                AnimatedCrossFade(
                  crossFadeState: bloc.isCodeReceived
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                  firstCurve: Curves.fastLinearToSlowEaseIn,
                  secondCurve: Curves.fastLinearToSlowEaseIn,
                  secondChild: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("Sent to : (+963) ${bloc.phoneController.text}",
                        style: TextStyle(
                          letterSpacing: .05,
                          fontSize: 20,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  firstChild:  Text(
                    'mobile phone',
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
