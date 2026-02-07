import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_wrapper_state.dart';

class MainWrapperCubit extends Cubit<MainWrapperState> {
  MainWrapperCubit() : super(const MainWrapperState(selectedIndex: 0));

  void changeIndex(int index) {
    emit(MainWrapperState(selectedIndex: index));
  }
}
