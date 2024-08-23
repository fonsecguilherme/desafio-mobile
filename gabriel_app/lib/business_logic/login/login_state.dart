sealed class LoginState {}

final class InitialLoginState extends LoginState {}

final class LoadingLoginState extends LoginState {}

final class SuccessLoginState extends LoginState {}

final class ErrorLoginState extends LoginState {
  final String errorMessage;

  ErrorLoginState({required this.errorMessage});
}
