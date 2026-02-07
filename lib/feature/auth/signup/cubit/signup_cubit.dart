import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> emitSignupStates() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(SignupLoading());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Simulate Success/Failure logic (Mock)
    try {
      // For demonstration, if email contains 'error', we fail.
      if (emailController.text.toLowerCase().contains('error')) {
        emit(SignupFailure(errorMessage: 'Signup Failed: Simulated Error'));
      } else {
        emit(SignupSuccess());
      }
    } catch (e) {
      emit(SignupFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
