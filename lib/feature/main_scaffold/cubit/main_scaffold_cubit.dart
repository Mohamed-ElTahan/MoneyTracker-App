import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_scaffold_state.dart';

class MainScaffoldCubit extends Cubit<MainScaffoldState> {
  MainScaffoldCubit() : super(const InitialMainScaffoldState(selectedIndex: 0));

  void changeIndex(int index) {
    emit(ChangeIndexState(selectedIndex: index));
  }
}
