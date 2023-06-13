import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccination/Logic/cubit/auth_cubit_cubit.dart';

import '../widgets/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isParent = false;
  final String font = 'JetBrainsMono';
  // final TextEditingController _nniController = TextEditingController();
  // final TextEditingController _nomController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height / 2.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Image.asset(
                        'Img/vaccinated.png',
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                    const Text(
                      'Vacciné',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // color: Colors.green,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  // crossAxisAlignment: Cro,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: CustomTextField(
                        obscurity: false,
                        maxLength: 20,
                        textInputType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        fieldName: 'Phone :',
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 1.1,
                        controller: _phoneController,
                      ),
                    ),
                    Center(
                      child: CustomTextField(
                        obscurity: true,
                        maxLength: 20,
                        // textInputType: const TextInputType.numberWithOptions(
                        //     signed: true, decimal: true),
                        fieldName: 'Password :',
                        height: MediaQuery.of(context).size.height / 16,
                        width: MediaQuery.of(context).size.width / 1.1,
                        controller: _passwordController,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: MaterialButton(
                      // shape: ShapeBorder(),
                      color: Colors.greenAccent[200],
                      onPressed: () async {
                        context.read<AuthCubitCubit>().login(
                            _phoneController.text, _passwordController.text);
                        // print(isParent);
                        // print(_nniController.text);
                      },
                      child: const Text(
                        'Se connecter',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<AuthCubitCubit>().signUpScreen();
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Vous n\'avez pas de compte ? ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                context.read<AuthCubitCubit>().signUpScreen(),
                          text: 'Créez un compte',
                          style: const TextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
