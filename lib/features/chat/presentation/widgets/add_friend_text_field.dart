import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/images.dart';

class AddFriendTextField extends StatelessWidget {
  const AddFriendTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: 24, right: 24, top: size.height * .129 + 32, bottom: 12),
        child: Theme(
          data: ThemeData(
              textSelectionTheme: const TextSelectionThemeData(
                  selectionHandleColor: Color(0xFF40C4FF),
                  selectionColor: Color(0x4C40C4FF))),
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            cursorColor: const Color(0xFF40C4FF),
            cursorHeight: 18,
            cursorWidth: 1,
            style: const TextStyle(
                color: Color(0xFF0D1217),
                fontWeight: FontWeight.w400,
                fontSize: 16),
            contextMenuBuilder:
                (BuildContext context, EditableTextState editableTextState) {
              final List<ContextMenuButtonItem> buttonItems =
                  editableTextState.contextMenuButtonItems;
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: buttonItems,
              );
            },
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    child: Image(
                      image: AssetImage(AppImages.syriaFlag),
                      width: 33,
                      height: 24,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "(+963)",
                    style: TextStyle(
                        color: Color(0xFF9A9BB1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 12),
                ],
              ),
              hintText: 'Enter Phone Number',
              hintStyle: TextStyle(color: Color(0x4C0D1217)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xFFD0D1DB))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xFFD0D1DB))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xFFD0D1DB))),
            ),
          ),
        ),
      ),
    );
  }
}
