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
            appBar: AppBar(
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
            ),
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
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.black,
              elevation: 0.0,
              backgroundColor: Colors.white,
              currentIndex: _selectedIndex,
              onTap: navigateBottomBar,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(FluentSystemIcons.ic_fluent_home_filled),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      FluentSystemIcons.ic_fluent_people_community_filled,
                    ),
                    label: 'Mes enfants'),
                BottomNavigationBarItem(
                    icon: Icon(
                      FluentSystemIcons.ic_fluent_map_filled,
                    ),
                    label: 'Near by centers'),
              ],
            ),
            body: SafeArea(
              bottom: false,
              child: _pages[_selectedIndex],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
