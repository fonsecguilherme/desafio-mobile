import 'package:bloc/bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  Future<void> userLogin({
    required String username,
    required String password,
  }) async {
    emit(LoadingLoginState());

    Future.delayed(const Duration(seconds: 3));

    if (username.isEmpty || password.isEmpty) {
      emit(ErrorLoginState(
          errorMessage: "Parece que você esqueceu de preencher algum campo!"));
    } else if (username == 'gabriel' && password == '140120') {
      emit(SuccessLoginState());
    } else {
      emit(ErrorLoginState(errorMessage: 'Login ou senha inválidos'));
    }
  }
}
