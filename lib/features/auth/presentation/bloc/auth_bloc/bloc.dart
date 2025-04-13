import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constants.dart';
import '../../../../../injection.dart' as di;

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final PageController pageController = PageController();
  final List<TextEditingController> codeControllers =
      List.generate(6, (inedex) => TextEditingController());
  String realPhone = '';
  bool rememberMe = false;

  ///for [AnimationController]
  bool isCircle = false;

  /// for submit code validation
  bool isFailedRequest = false;

  /// for submit phone number
  bool isCodeReceived = false;

  /// for Register account to pick profile image
  bool isValidCode = false;

  /// I put the image of profile because name and image picker
  /// each one in another widget
  String? profileImage;
  AuthBloc() : super(AuthInitial()) {
    on<ResetSettings>((event, emit) {
      phoneController.text = "";
      nameController.text = "";
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
      for (int i = 0; i < 6; i++) {
        codeControllers[i].text = "";
      }
      realPhone = '';
      rememberMe = false;
      isCircle = false;
      isFailedRequest = false;
      isCodeReceived = false;
      isValidCode = false;
      emit(AuthInitial());
    });
    on<IsValidPhoneEvent>((event, emit) {
      //! How does it work?
      if (phoneController.text.length >= 9 &&
          !phoneController.text.contains(' ')) {
        String current = '';
        for (int i = 0; i < phoneController.text.length; i++) {
          current += phoneController.text[i];
          if (i == 2 || i == 5) current += ' ';
        }
        realPhone = '+963${phoneController.text}';
        //? these way for a beautiful format for user
        phoneController.text = current;
        // realPhone = '+4915771066062';
        print(realPhone);
        emit(EnableSubmitButton());
      } else if (phoneController.text.contains(' ')) {
        emit(EnableSubmitButton());
      } else {
        emit(DisableSubmitButton());
      }
    });
    on<RemmberMeEvent>((event, emit) {
      rememberMe = event.remmberMe;
      emit(RemmeberMe());
      add(IsValidPhoneEvent());
    });
    on<SendVerifictationCode>((event, emit) async {
      try {
        emit(Loading());
        if (!event.isLogin) isCircle = true;
        List<Map<String, dynamic>> listOfUsers =
            await Supabase.instance.client.from('users').select('phone');
        print("finish query");
        List<String> users = [];
        for (Map<String, dynamic> user in listOfUsers) {
          users.add(user['phone']);
        }
        print("finish for");
        print(listOfUsers);
        if (event.isLogin && !users.contains(realPhone)) {
          throw "user-not-found";
        } else if (!event.isLogin && users.contains(realPhone)) {
          throw "user-already-exist";
        }
        // await Future.delayed(const Duration(milliseconds: 2000));

        //! what is this???!!!
        // if (event.isLogin) {
        //   List<User> users =
        //       await Supabase.instance.client.auth.admin.listUsers();
        //   for (User user in users) {
        //     if (realPhone.endsWith(user.phone ?? '')) {
        //       throw "user-already-exists";
        //     }
        //   }
        // }

        // await Supabase.instance.client.auth.signInWithOtp(phone: realPhone);
        isCodeReceived = true;
        print(pageController.page);
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        log("Send Successfully");
        emit(CodeIsReceived());
      } catch (e) {
        emit(Failure(message: e.toString()));
      }
    });
    on<VerifyCode>((event, emit) async {
      try {
        emit(Loading());
        String code = '';
        for (final codeCon in codeControllers) {
          code += codeCon.text;
        }
        print(code);
        await Future.delayed(const Duration(milliseconds: 1000));
        if (code == '000000') throw 'Invalid Code';
        // final AuthResponse res = await Supabase.instance.client.auth.verifyOTP(
        //   type: OtpType.sms,
        //   token: code,
        //   phone: realPhone,
        // );
        // final Session? session = res.session;
        // final User? user = res.user;
        // print(session.toString());
        // print(user.toString());
        isValidCode = true;
        isFailedRequest = false;
        if (event.isLogin) {
          await di
              .sl<SharedPreferences>()
              .setBool(Constants.isRemembered, rememberMe);
        }
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        event.animationController.reverse();
        emit(event.isLogin ? Success() : CodeIsValid());
      } catch (e) {
        isFailedRequest = true;
        emit(Failure(message: e.toString()));
      }
    });
    on<UploadAvatar>((event, emit) async {
      try {
        emit(Loading());
        await di
            .sl<SharedPreferences>()
            .setBool(Constants.isRemembered, rememberMe);
        String publicUrl = '';
        if (profileImage != null) {
          int here = 0;
          String temp = 'users/$realPhone';
          for (int i = profileImage!.length - 1; i > 0; i--) {
            if (profileImage![i] == '/') {
              here = i;
              break;
            }
          }
          for (int i = here + 1; i < profileImage!.length; i++) {
            temp += profileImage![i];
          }
          await Supabase.instance.client.storage.from("images").upload(
                temp,
                File(profileImage!),
                fileOptions: const FileOptions(upsert: true),
              );
          print('done uploading image');
          publicUrl = Supabase.instance.client.storage
              .from('images')
              .getPublicUrl(temp);
          print('Image Url = $publicUrl');
        }
        await Supabase.instance.client.from('users').insert({
          'phone': realPhone,
          'name': nameController.text,
          'image_url': publicUrl,
        });
        print('done sign up');
        emit(Success());
      } catch (e) {
        emit(Failure(message: e.toString()));
      }
    });
    on<CheckCodeFields>((event, emit) {
      bool isValid = true;
      for (final con in codeControllers) {
        if (con.text == '') {
          isValid = false;
          break;
        }
      }
      emit(isValid ? EnableSubmitButton() : DisableSubmitButton());
    });
  }
}
