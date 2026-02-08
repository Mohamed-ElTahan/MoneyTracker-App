import 'package:equatable/equatable.dart';

sealed class MainScaffoldState extends Equatable {
  final int selectedIndex;
  const MainScaffoldState({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}

class InitialMainScaffoldState extends MainScaffoldState {
  const InitialMainScaffoldState({required super.selectedIndex});
}

class ChangeIndexState extends MainScaffoldState {
  const ChangeIndexState({required super.selectedIndex});
}
