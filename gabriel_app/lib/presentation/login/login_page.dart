import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gabriel_app/business_logic/locations/locations_cubit.dart';
import 'package:gabriel_app/data/repository/gabriel_repository.dart';
import 'package:gabriel_app/presentation/locations/locations_page.dart';
import 'package:gabriel_app/utils/messages.dart';

import '../../business_logic/login/login_cubit.dart';
import '../../business_logic/login/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit get loginCubit => context.read<LoginCubit>();
  IGabrielRepository get repository => context.read<IGabrielRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: loginCubit,
        listener: (context, state) {
          if (state is ErrorLoginState) {
            Messages.of(context).showError(state.errorMessage);
          } else if (state is SuccessLoginState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => LocationsCubit(
                    repository: repository,
                  ),
                  child: const LocationsPage(),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case LoadingLoginState():
              return const Center(
                child: CircularProgressIndicator(),
              );

            default:
              return const LoginInitialWidget();
          }
        },
      ),
    );
  }
}

class LoginInitialWidget extends StatefulWidget {
  const LoginInitialWidget({super.key});

  @override
  State<LoginInitialWidget> createState() => _LoginInitialWidgetState();
}

class _LoginInitialWidgetState extends State<LoginInitialWidget> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  LoginCubit get loginCubit => context.read<LoginCubit>();

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          const Spacer(),
          const SizedBox(
            width: 150,
            height: 150,
            child: Image(
              image: AssetImage('assets/logo.png'),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Bem-vindo!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Para começar, digite seu usuário e senha',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: loginController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.keyboard),
              contentPadding: const EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: 'Usuário',
              fillColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            maxLength: 18,
            controller: passwordController,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.key),
              contentPadding: const EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: 'Senha',
              fillColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                loginCubit.userLogin(
                  username: loginController.text.trim(),
                  password: passwordController.text,
                );
              },
              child: const Text('Login'),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
