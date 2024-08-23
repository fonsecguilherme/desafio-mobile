import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_app/business_logic/login/login_cubit.dart';
import 'package:gabriel_app/business_logic/login/login_state.dart';

void main() {
  group('Login success', () {
    blocTest<LoginCubit, LoginState>(
      'shoud emit SuccessLoginState when password and '
      'username satisfied login condition',
      build: () => LoginCubit(),
      act: (cubit) => cubit.userLogin(username: 'gabriel', password: '140120'),
      expect: () => <LoginState>[
        LoadingLoginState(),
        SuccessLoginState(),
      ],
    );
  });

  group('Login errors when user input does not satified login condition', () {
    blocTest<LoginCubit, LoginState>(
      'shoud emit ErrorLoginState when username has not been filled',
      build: () => LoginCubit(),
      act: (cubit) => cubit.userLogin(username: '', password: '1234'),
      expect: () => <LoginState>[
        LoadingLoginState(),
        ErrorLoginState(
            errorMessage: "Parece que você esqueceu de preencher algum campo!"),
      ],
    );
    blocTest<LoginCubit, LoginState>(
      'shoud emit ErrorLoginState when password has not been filled',
      build: () => LoginCubit(),
      act: (cubit) => cubit.userLogin(username: 'gabigol', password: ''),
      expect: () => <LoginState>[
        LoadingLoginState(),
        ErrorLoginState(
            errorMessage: "Parece que você esqueceu de preencher algum campo!"),
      ],
    );
    blocTest<LoginCubit, LoginState>(
      'shoud emit ErrorLoginState when username and password haven\'t match login',
      build: () => LoginCubit(),
      act: (cubit) => cubit.userLogin(username: 'gabigol', password: '1401200'),
      expect: () => <LoginState>[
        LoadingLoginState(),
        ErrorLoginState(errorMessage: 'Login ou senha inválidos'),
      ],
    );
  });
}
