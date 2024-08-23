import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gabriel_app/business_logic/login/login_cubit.dart';
import 'package:gabriel_app/presentation/login/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginPage(),
      ));
}
