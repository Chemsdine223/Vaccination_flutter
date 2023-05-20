import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccination/Logic/cubit/auth_cubit_cubit.dart';
import 'package:vaccination/Screens/home.dart';
import 'package:vaccination/Screens/login.dart';
import 'package:vaccination/Screens/login_screen.dart';

import '../Screens/loading.dart';

class Logic extends StatefulWidget {
  const Logic({super.key});

  @override
  State<Logic> createState() => _LogicState();
}

class _LogicState extends State<Logic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubitCubit(),
        child: BlocConsumer<AuthCubitCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is AuthCubitError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMsg,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'JetBrainsMono',
                      fontSize: 16,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthCubitLoading) {
              return const LoadingScreen();
            } else if (state is AuthCubitSuccess) {
              return const HomeScreen();
            } else if (state is SignUpScreen) {
              return const LoginScreen();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
