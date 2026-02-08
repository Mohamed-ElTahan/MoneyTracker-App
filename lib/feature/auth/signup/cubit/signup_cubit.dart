import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/core/data_source/firebase_data_source.dart';
import 'package:money_tracker_app/feature/auth/models/user_model.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final FirebaseDataSource firebaseDataSource = FirebaseDataSource();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signUp(UserModel user) async {
    emit(SignupLoading());
    try {
      await firebaseDataSource.signUp(
        email: user.email,
        password: user.password,
        name: user.name,
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(errorMessage: e.toString()));
    }
  }

  Future<void> emitSignupStates() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Create UserModel from form controllers
    final user = UserModel(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      fev: [],
    );

    // Call the real Firebase signup
    await signUp(user);
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
