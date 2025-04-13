import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/images.dart';
import '../../../../../core/theme_bloc/theme_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
  });
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: const Color(0xFF40C4FF).withOpacity(.5),
          selectionHandleColor: const Color(0xFF40C4FF),
        ),
      ),
      child: TextFormField(
        cursorColor: const Color(0xFF40C4FF),
        onChanged: onChanged,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11)
        ],
        style: TextStyle(
            fontSize: 24,
            fontWeight: context.read<ThemeBloc>().darkTheme
                ? FontWeight.w500
                : FontWeight.w400,
            color: context.read<ThemeBloc>().darkTheme
                ? const Color(0xFFF0F0F3)
                : const Color(0xFF2C2D3A)),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        contextMenuBuilder:
            (BuildContext context, EditableTextState editableTextState) {
          final List<ContextMenuButtonItem> buttonItems =
              editableTextState.contextMenuButtonItems;
          return AdaptiveTextSelectionToolbar.buttonItems(
            anchors: editableTextState.contextMenuAnchors,
            buttonItems: buttonItems,
          );
        },
        decoration: InputDecoration(
          prefixIcon: const Align(
            alignment: AlignmentDirectional.centerStart,
            widthFactor: 1,
            child: SizedBox(
              width: 125,
              child: Row(
                children: [
                  SizedBox(width: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    child: Image(
                      image: AssetImage(AppImages.syriaFlag),
                      width: 25,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "(+963)",
                    style: TextStyle(
                        color: Color(0xFF9A9BB1),
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
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
          hintText: hintText,
          hintStyle: TextStyle(
              color: context.read<ThemeBloc>().darkTheme
                  ? const Color(0xFFF0F0F3).withOpacity(.3)
                  : const Color(0xFF9A9BB1),
              fontSize: 24,
              fontWeight: context.read<ThemeBloc>().darkTheme
                  ? FontWeight.w500
                  : FontWeight.w400),
        ),
      ),
    );
  }
}
