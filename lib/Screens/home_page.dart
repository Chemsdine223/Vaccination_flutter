import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccination/Logic/cubit/auth_cubit_cubit.dart';
import 'package:vaccination/Screens/loading.dart';
import 'package:vaccination/widgets/vaccination_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubitCubit, AuthCubitState>(
      builder: (context, state) {
        return Scaffold(
          // extendBody: true,
          // floatingActionButton: FloatingActionButton(onPressed: () {}),
          backgroundColor: Colors.white,
          body: BlocBuilder<AuthCubitCubit, AuthCubitState>(
            builder: (context, state) {
              if (state is AuthCubitSuccess) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: VaccinationCard(
                        nom: state.userModel.nom,
                        prenom: state.userModel.prenom,
                        centre: state.vaccination.centre,
                        status: state.vaccination.status,
                      ),
                    ),
                  ],
                );
              } else if (state is AuthCubitLoading) {
                return LoadingScreen();
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}
