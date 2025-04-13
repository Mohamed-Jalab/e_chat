import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/images.dart';
import '../../bloc/auth_bloc/bloc.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key, required this.show});
  final bool show;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          height: widget.show ? size.width * .39 : 0,
          width: widget.show ? size.width * .39 : 0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                  width: size.width * .35,
                  height: size.width * .35,
                  child: Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                        color: imagePath == null
                            ? Colors.transparent
                            : Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * .35 / 2))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(size.width * .35 / 2),
                      child: Image(
                        image: (imagePath == null
                            ? const AssetImage(AppImages.profile)
                            : FileImage(File(imagePath!))) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Positioned(
                top: size.height * 0.01,
                right: 0,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(42 / 2)),
                    onTap: () async {
                      imagePath = await showModalBottomSheet<String?>(
                          context: context,
                          builder: (context) => const BottomSheetWidget());
                      if (context.mounted) {
                        context.read<AuthBloc>().profileImage = imagePath;
                      }
                      setState(() {});
                    },
                    child: Ink(
                        width: size.width * .1,
                        height: size.width * .1,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Color(0xFF1565C0), Color(0xFF0F4888)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(AppImages.pen),
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.vertical,
      children: [
        const SizedBox(height: 7),
        Container(
            width: 60,
            height: 4,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30)))),
        const SizedBox(height: 7),
        ListTile(
            onTap: () async {
              final XFile? image =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (context.mounted) Navigator.of(context).pop(image?.path);
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            leading: const Icon(Icons.camera_alt_rounded),
            title: const Text("Photo")),
        const SizedBox(height: 5),
        ListTile(
            onTap: () async {
              final XFile? image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (context.mounted) Navigator.of(context).pop(image?.path);
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            leading: const Icon(Icons.image_rounded),
            title: const Text("Gallery")),
      ],
    );
  }
}
