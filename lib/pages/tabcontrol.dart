import 'package:flutter/material.dart';
import 'package:gambit/components/custom_tile.dart';

import 'package:gambit/pages/games_page.dart';
import 'package:gambit/pages/home_page.dart';
import 'package:gambit/pages/leaderboard.dart';

import 'package:gambit/pages/profile_page.dart';
import 'package:gambit/pages/settings_page.dart';
import 'package:gambit/pages/texttheme.dart';

class TabBarController extends StatelessWidget {
  const TabBarController({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/back2.jpg')),
        ),
        child: Drawer(
          backgroundColor: Colors.transparent,
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
              SizedBox(
                height: 5,
              ),
              CustomBorderTile('Settings ', 3, Icons.settings),
              SizedBox(
                height: 5,
              ),
              CustomBorderTile('Analytics ', null, Icons.show_chart_rounded),
              SizedBox(
                height: 5,
              ),
              CustomBorderTile('History ', null, Icons.book_outlined),
              SizedBox(
                height: 5,
              ),
              CustomBorderTile('Learn ', null, Icons.school),
              SizedBox(
                height: 5,
              ),
              CustomBorderTile('Social ', null, Icons.people_alt_rounded),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: CustomBorderTile('Log Off ', null, Icons.logout_rounded),
              ),
            ],
          ),
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
          children: [HomePage(), LeaderPage(), ProfilePage(), SettingsPage()],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.black87,
        child: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.leaderboard)),
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
