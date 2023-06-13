part of 'auth_cubit_cubit.dart';

@immutable
abstract class AuthCubitState extends Equatable {}

class AuthCubitInitial extends AuthCubitState {
  @override
  List<Object?> get props => [];
}

class AuthCubitLoading extends AuthCubitState {
  @override
  List<Object?> get props => [];
}

class Starting extends AuthCubitState {
  @override
  List<Object?> get props => [];
}

class AuthCubitSuccess extends AuthCubitState {
  final UserModel userModel;
  final Vaccination vaccination;

  AuthCubitSuccess(
    this.userModel,
    this.vaccination,
  );
  @override
  List<Object?> get props => [userModel];
}

class AuthCubitError extends AuthCubitState {
  final String errorMsg;

  AuthCubitError(this.errorMsg);
  @override
  List<Object?> get props => [errorMsg];
}

class SignUpScreen extends AuthCubitState {
  // final String errorMsg;

  SignUpScreen();
  @override
  List<Object?> get props => [];
}
