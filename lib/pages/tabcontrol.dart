import 'package:flutter/material.dart';
import 'package:gambit/components/custom_tile.dart';

import 'package:gambit/pages/games_page.dart';
import 'package:gambit/pages/home_page.dart';

import 'package:gambit/pages/profile_page.dart';
import 'package:gambit/pages/settings_page.dart';
import 'package:gambit/pages/texttheme.dart';

class TabBarController extends StatelessWidget {
  const TabBarController({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 168, 103, 12),
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  backgroundBlendMode: BlendMode.colorBurn),
              child: Image(image: AssetImage('assets/images/gambit5.jpg')),
            ),
            CustomBorderTile('Home ', 0, Icons.home),
            CustomBorderTile('Settings ', 3, Icons.settings),
            CustomBorderTile('Analytics ', null, Icons.show_chart_rounded),
            CustomBorderTile('History ', null, Icons.book_outlined),
            CustomBorderTile('Learn ', null, Icons.school),
            CustomBorderTile('Social ', null, Icons.people_alt_rounded),
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: CustomBorderTile('Log Off ', null, Icons.logout_rounded),
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerboxisScrolled) {
          return [
            const SliverAppBar(
              pinned: true,
              centerTitle: true,
              title: TextTheme2("Gambit"),
              backgroundColor: Colors.black87,
              floating: false,
              //actions: [LogOff()],
            ),
          ];
        },
        body: const TabBarView(
          children: [HomePage(), GamePage(), ProfilePage(), SettingsPage()],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.black87,
        child: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.games)),
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
