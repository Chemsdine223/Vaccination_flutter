import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccination/Logic/cubit/auth_cubit_cubit.dart';
import 'package:vaccination/Screens/map_page.dart';
import 'package:vaccination/Screens/my_kids.dart';

import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    HomePage(),
    MyChildrenScreen(),
    MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubitCubit, AuthCubitState>(
      builder: (context, state) {
        if (state is AuthCubitSuccess) {
          return Scaffold(
            extendBody: true,
            appBar: _selectedIndex != 2
                ? AppBar(
                    centerTitle: true,
                    title: const Text(
                      'Vacciné',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                    leading: Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          FluentSystemIcons.ic_fluent_navigation_regular,
                          size: 40,
                        ),
                      );
                    }),
                    toolbarHeight: MediaQuery.of(context).size.height / 11,
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                  )
                : null,
            body: _pages[_selectedIndex],
            drawer: Drawer(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Container(
                color: Colors.white,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        DrawerHeader(
                          child: Image.asset('Img/vaccinated.png'),
                        ),
                        Text(
                          state.userModel.nom,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.6,
                        )
                      ],
                    ),
                    ListTile(
                      onTap: () {
                        context.read<AuthCubitCubit>().logOut();
                        debugPrint('Bye');
                      },
                      leading: const Icon(Icons.logout),
                      title: const Text(
                        'Sign out',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: CurvedNavigationBar(
              index: 0,
              onTap: navigateBottomBar,
              // scaleFactor: 1.5,

              // animationCurve: Curves.decelerate,
              // backgroundColor: Colors.transparent
              // ,
              // style: FluidNavBarStyle(
              //   barBackgroundColor: color,
              //   iconBackgroundColor: Colors.transparent,
              // ),
              backgroundColor: Colors.transparent,
              color: Colors.greenAccent[200]!,
              buttonBackgroundColor: Colors.greenAccent[600],

              items: const [
                // Icon(Icons.home),
                Icon(Icons.home, color: Colors.white),
                Icon(Icons.emoji_people, color: Colors.white),
                Icon(Icons.map_rounded, color: Colors.white),
                // Icon(Icons.history, color: Colors.white),
                // Icon(Icons.person, color: Colors.white),
              ],
              // color: color!,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
