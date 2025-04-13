import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme_bloc/theme_bloc.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height,
      color: context.read<ThemeBloc>().darkTheme
          ? const Color(0x4F596464)
          : const Color(0x4F8E9E9E),
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFF05aaf4)),
      ),
    );
  }
}
