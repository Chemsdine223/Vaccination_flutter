import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../Data/Models/user.dart';
import '../../Data/auth/auth_service.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit() : super(AuthCubitInitial());

  Future<void> loadingScreen() async {
    emit(Starting());
    await Future.delayed(Duration(seconds: 3));
    emit(AuthCubitInitial());
  }

  Future<void> login(String phone, String password) async {
    emit(AuthCubitLoading());
    await AuthService.loadTokens();

    try {
      final response = await AuthService.signIn(phone, password);
      final vaccination = await VaccinationRepo.getVaccines();
      emit(AuthCubitSuccess(response, vaccination));
    } catch (e) {
      // print(e);
      emit(AuthCubitError('Something went wrong'));
    }
  }

  Future<void> getVaccination() async {}

  void logOut() {
    AuthService.clearTokens();
    emit(AuthCubitInitial());
  }

  void signUpScreen() {
    AuthService.clearTokens();
    emit(SignUpScreen());
  }

  void goHome() {
    // AuthService.clearTokens();
    emit(AuthCubitInitial());
  }
}
