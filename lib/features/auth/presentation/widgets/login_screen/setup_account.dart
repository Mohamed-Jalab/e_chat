import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/bloc.dart';
import '../../screens/opt_screen.dart';
import 'custom_icon_button.dart';
import 'name_text_field.dart';

class SetupAccount extends StatefulWidget {
  const SetupAccount({super.key});

  @override
  State<SetupAccount> createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
  bool enableButton = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Success) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const OptScreen(),
            ));
          }
        },
        builder: (context, state) {
          AuthBloc bloc = BlocProvider.of(context);
          //! the Image is in login_screen.dart for Animation
          return Column(
            children: [
              const Spacer(),
              NameTextField(
                controller: bloc.nameController,
                onChange: (value) {
                  //? I make this condition to not rebuild
                  //? the page for each letter in [TextField]
                  if (value.length >= 3 && !enableButton) {
                    setState(() {
                      enableButton = true;
                    });
                    print("rebuild name page");
                  } else if (enableButton && value.length < 3) {
                    setState(() {
                      enableButton = false;
                    });
                    print("rebuild name page");
                  }
                },
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomIconButton(
                    icon: Icons.arrow_forward_rounded,
                    onTap: enableButton
                        ? () {
                            bloc.add(UploadAvatar());
                          }
                        : null,
                  )
                ],
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
