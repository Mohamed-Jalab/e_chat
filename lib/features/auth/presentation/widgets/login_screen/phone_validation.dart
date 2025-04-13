import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/bloc.dart';
import 'custom_icon_button.dart';
import 'custom_text_field.dart';

class PhoneValidation extends StatelessWidget {
  const PhoneValidation({super.key, required this.isLogin});
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          AuthBloc bloc = BlocProvider.of(context);
          return Column(
            children: [
              Text("You will get a code via sms.",
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              CustomTextField(
                controller: bloc.phoneController,
                hintText: '00 0000 0000',
                onChanged: (value) {
                  print('bloc.add(IsValidPhoneEvent())');
                  bloc.add(IsValidPhoneEvent());
                },
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                      width: 160,
                      //TODO: to make the active Color in gradient
                      child: CheckboxListTile(
                        side: const BorderSide(color: Color(0xFFBABDC1)),
                        checkboxShape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        hoverColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        activeColor: const Color(0xFF03A9F4),
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        value: bloc.rememberMe,
                        title: const Text(
                          "Remmber me",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        onChanged: (value) {
                          bloc.add(RemmberMeEvent(remmberMe: value ?? false));
                        },
                      )),
                  const Spacer(),
                  CustomIconButton(
                      icon: Icons.arrow_forward_rounded,
                      onTap: state is EnableSubmitButton
                          ? () {
                              print('=========submit');
                              bloc.add(SendVerifictationCode(isLogin: isLogin));
                            }
                          : null),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
