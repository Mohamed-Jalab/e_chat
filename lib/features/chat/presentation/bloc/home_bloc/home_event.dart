// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class MenuEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {}

class ChangePageEvent extends HomeEvent {
  final int index;
  ChangePageEvent({required this.index});
}
