part of 'bloc.dart';

abstract class AuthEvent {}

class IsValidPhoneEvent extends AuthEvent {}

class RemmberMeEvent extends AuthEvent {
  final bool remmberMe;

  RemmberMeEvent({required this.remmberMe});
}

class SendVerifictationCode extends AuthEvent {
  final bool isLogin;

  SendVerifictationCode({required this.isLogin});
}

class VerifyCode extends AuthEvent {
  final bool isLogin;
  final AnimationController animationController;
  VerifyCode( {required this.animationController,required this.isLogin});
}

class CheckCodeFields extends AuthEvent {}

class ResetSettings extends AuthEvent {}

class UploadAvatar extends AuthEvent {}
