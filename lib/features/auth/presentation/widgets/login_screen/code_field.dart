import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme_bloc/theme_bloc.dart';

class CodeField extends StatelessWidget {
  const CodeField({
    super.key,
    this.controller,
    this.isFailed = false,
    this.onChanged,
  });
  final TextEditingController? controller;
  final bool isFailed;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: const Color(0xFF40C4FF).withOpacity(.5),
          selectionHandleColor: const Color(0xFF40C4FF),
        ),
      ),
      child: SizedBox(
        width: 45,
        child: TextFormField(
          onChanged: onChanged,
          textAlign: TextAlign.center,
          cursorColor: const Color(0xFF40C4FF),
          cursorErrorColor: const Color(0xFFF44336),
          // onChanged: onChanged,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1)
          ],
          style:  TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: context.read<ThemeBloc>().darkTheme
                  ? const Color(0xFFF0F0F3)
                  : const Color(0xFF2C2D3A)),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          controller: controller,
          decoration: InputDecoration(
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
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF44336), width: 3)),
            focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF44336), width: 3)),
            error: !isFailed ? null : const SizedBox(),
            errorText: null,
            hintStyle: const TextStyle(
                color: Color(0xFF9A9BB1),
                fontSize: 24,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
