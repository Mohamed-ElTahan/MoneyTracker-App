import 'package:equatable/equatable.dart';

sealed class MainScaffoldState extends Equatable {
  final int index;
  const MainScaffoldState({required this.index});

  @override
  List<Object?> get props => [index];
}

class InitialMainScaffoldState extends MainScaffoldState {
  const InitialMainScaffoldState({required super.index});
}

class ChangeIndexState extends MainScaffoldState {
  const ChangeIndexState({required super.index});
}
