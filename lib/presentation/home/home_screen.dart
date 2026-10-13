import 'package:evently/presentation/home/tabs/fav_tab/fav_tab.dart';
import 'package:evently/presentation/home/tabs/home_tab/home_tab.dart';
import 'package:evently/presentation/home/tabs/home_tab/home_tab_provider/home_tab_provider.dart';

import 'package:evently/presentation/home/tabs/profile_tab/profile_tab.dart';
import 'package:evently/presentation/home/widgets/home_header.dart';
import 'package:evently/presentation/new_event/new_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currantTabIndex = 0;
  List<Widget> tabs() => [HomeTab(), FavTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventsProvider(),
      child: Scaffold(
        body: tabs()[currantTabIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 0,

          backgroundColor: Theme.of(context).cardColor,
          onPressed: () async {
            var data = await Navigator.pushNamed(
              context,
              NewEventScreen.routeName,
            );
            if (data == true) {
              setState(() {});
            }
          },
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 5)),
          child: Icon(Icons.add, color: Colors.white),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor: Theme.of(context).cardColor,
          unselectedItemColor: Theme.of(context).hintColor,
          currentIndex: currantTabIndex,
          onTap: (value) {
            setState(() {
              currantTabIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: "fav",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              activeIcon: Icon(Icons.person_2),
              label: "profile",
            ),
          ],
        ),
      ),
    );
  }
}
//shared prefrance || cashing
//firebase
