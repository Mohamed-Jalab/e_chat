import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/bloc.dart';
import 'code_field.dart';
import 'custom_icon_button.dart';
import 'resend_code.dart';

class CodeVerification extends StatelessWidget {
  const CodeVerification(
      {super.key, required this.isLogin, required this.animationController});
  final bool isLogin;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print('===build code verfication===');
          AuthBloc bloc = BlocProvider.of(context);
          return Column(
            children: [
              const ResendCode(),
              const Spacer(),
              const CodeVerificationForm(),
              AnimatedCrossFade(
                firstChild: const SizedBox(height: 20),
                secondChild: const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Code Invalid",
                    style: TextStyle(
                      color: Color(0xFFFF6347),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                crossFadeState: bloc.isFailedRequest
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 150),
                sizeCurve: Curves.decelerate,
                firstCurve: Curves.decelerate,
                secondCurve: Curves.decelerate,
              ),
              Row(
                children: [
                  const Spacer(),
                  CustomIconButton(
                    icon: Icons.arrow_forward_rounded,
                    onTap: state is EnableSubmitButton
                        ? () {
                            print('=========submit');
                            //* this [AnimationController] to just pass it to Bloc
                            //* to run animationController.reverse();
                            bloc.add(VerifyCode(
                                isLogin: isLogin,
                                animationController: animationController));
                          }
                        : null,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CodeVerificationForm extends StatefulWidget {
  const CodeVerificationForm({super.key});
  @override
  State<CodeVerificationForm> createState() => _CodeVerificationFormState();
}

class _CodeVerificationFormState extends State<CodeVerificationForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("======build CodeVerificationForm======");
    return Form(
        key: globalKey,
        autovalidateMode: AutovalidateMode.always,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            AuthBloc bloc = BlocProvider.of(context);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => CodeField(
                  onChanged: (value) {
                    bloc.add(CheckCodeFields());
                    if (value != '' && index != 5)
                      FocusScope.of(context).nextFocus();
                    if (value == '' && index != 0)
                      FocusScope.of(context).previousFocus();
                  },
                  isFailed: bloc.isFailedRequest,
                  controller: bloc.codeControllers[index],
                ),
              ),
            );
          },
        ));
  }
}
