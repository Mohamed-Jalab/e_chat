import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isMenuOpened = false;
  bool isSearchOpened = false;
  int selectedPage = 0;
  TextEditingController searchController = TextEditingController();
  PageController pageController = PageController();
  HomeBloc() : super(HomeInitial()) {
    on<MenuEvent>((event, emit) {
      isMenuOpened = !isMenuOpened;
      emit(ChangeScreenState());
    });
    on<SearchEvent>((event, emit) {
      isSearchOpened = !isSearchOpened;
      emit(ChangeScreenState());
    });
    on<ChangePageEvent>((event, emit) {
      // print("=============================");
      print("index in bloc = ${event.index}");
      
      selectedPage = event.index;
      pageController.animateToPage(event.index,
          duration: const Duration(milliseconds: 700),
          curve: Curves.fastLinearToSlowEaseIn);
      // print("should be reloaded");
      // print("=============================");
      emit(ChangeScreenState());
    });
  }
}
