part of 'bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class EnableSubmitButton extends AuthState {}

class DisableSubmitButton extends AuthState {}

class RemmeberMe extends AuthState {}

class Loading extends AuthState {}

class Failure extends AuthState {
  final String message;

  Failure({required this.message});
}

class Success extends AuthState {}

class CodeIsReceived extends AuthState {}

class CodeIsValid extends AuthState {}

class ImageUploaded extends AuthState {}