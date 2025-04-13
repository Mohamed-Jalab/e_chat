import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme_bloc/theme_bloc.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({super.key, this.controller, this.onChange});
  final TextEditingController? controller;
  final void Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.sizeOf(context);
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: const Color(0xFF40C4FF).withOpacity(.5),
          selectionHandleColor: const Color(0xFF40C4FF),
        ),
      ),
      child: TextFormField(
        buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) =>
            const SizedBox(),
        maxLength: 20,
        onChanged: onChange,
        controller: controller,
        cursorColor: const Color(0xFF40C4FF),
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: context.read<ThemeBloc>().darkTheme
                ? const Color(0xFFF0F0F3)
                : const Color(0xFF2C2D3A)),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 14, bottom: 14, right: 4),
          hintText: 'Your Name',
          //? I put the padding here to make padding in the left
          prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4, right: 16),
              child: Icon(Icons.person_rounded,
                  size: 32,
                  color: context.read<ThemeBloc>().darkTheme
                      ? const Color(0xFFF0F0F3)
                      : const Color(0xFF0D1217))),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: context.read<ThemeBloc>().darkTheme
                      ? const Color(0xFFD0D1DB)
                      : const Color(0xFF2C2D3A),
                  width: 3)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: context.read<ThemeBloc>().darkTheme
                      ? const Color(0xFFD0D1DB)
                      : const Color(0xFF2C2D3A),
                  width: 3)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF40C4FF), width: 3)),
          hintStyle: const TextStyle(
              color: Color(0xFF9A9BB1),
              fontSize: 24,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
