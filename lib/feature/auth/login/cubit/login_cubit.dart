import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/core/data_source/firebase_data_source.dart';
import 'package:money_tracker_app/feature/auth/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final FirebaseDataSource firebaseDataSource = FirebaseDataSource();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await firebaseDataSource.login(email: email, password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }

  Future<void> emitLoginStates() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Call the real Firebase login with email and password only
    await login(email: emailController.text, password: passwordController.text);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
