import 'package:chat_app/features/auth/presentation/widgets/login_screen/code_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/bloc.dart';
import 'phone_validation.dart';
import 'setup_account.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    super.key,
    required this.isLogin,
    required this.animationController,
  });
  final bool isLogin;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        AuthBloc bloc = BlocProvider.of(context);
        return SizedBox(
          height: 190,
          width: size.width,
          child: PageView(
            controller: bloc.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PhoneValidation(isLogin: isLogin),
              //* this [AnimationController] to just pass it to Bloc
              //* to run animationController.reverse();
              CodeVerification(
                isLogin: isLogin,
                animationController: animationController,
              ),
              const SetupAccount(),
            ],
          ),
        );
      },
    );
  }
}
