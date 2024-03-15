import 'package:flutter/material.dart';
import 'package:gambit/components/custom_tile.dart';
import 'package:gambit/components/start_logo.dart';
import 'package:gambit/learn/openings.dart';
import 'package:gambit/learn/resources.dart';
import 'package:gambit/learn/tutorial.dart';
import 'package:gambit/pages/basescreen.dart';
import 'package:gambit/pages/history_pg.dart';
import 'package:gambit/learn/learn_page.dart';
import 'package:gambit/pages/log_off.dart';
import 'package:gambit/pages/social_page.dart';

class Control2 extends StatefulWidget {
  const Control2({super.key});

  @override
  State<Control2> createState() => _Control2State();
}

class _Control2State extends State<Control2> {
  int _selectedIndex = 0;

  void getHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const BaseScreen(0)));
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.10;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        width: 220,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 160, 0, 1).withOpacity(0.8),
                ),
                child: const LogoBox(
                    imagePath: 'assets/images/prodigy1.png', logoHt: 200)),
            const CustomBorderTile(BaseScreen(0), 'Home ', null, Icons.home),

            const CustomBorderTile(
                BaseScreen(0), 'Settings ', null, Icons.settings),

            const CustomBorderTile(
                BaseScreen(1), 'Analytics ', null, Icons.show_chart_rounded),

            const CustomBorderTile(
                HistoryPage(), 'History ', null, Icons.book_outlined),

            const CustomBorderTile(null, 'Learn ', 0, Icons.school),

            const CustomBorderTile(
                SocialPage(), 'Social ', null, Icons.people_alt_rounded),
            // Pressing this tile will diplay another logoff page incase it
            // was pressed accidentally
            const CustomBorderTile(
                LogOff(), 'Log Off ', null, Icons.logout_rounded),
            Container(
              height: 150,
              decoration:
                  BoxDecoration(color: Colors.amber.shade700.withOpacity(0.8)),
              alignment: Alignment.bottomCenter,
              child: const Text(
                'Version 1.0.0',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: appBarHeight * 0.5),
        decoration: const BoxDecoration(color: Colors.black),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerboxisScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                centerTitle: true,
                title: SizedBox(
                  height: appBarHeight,
                  child: GestureDetector(
                      onDoubleTap: getHome,
                      child: const Image(
                          image: AssetImage('assets/images/prodigy1.png'))),
                ), //TextTheme2("Gambit"),
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                floating: false,
                //actions: [LogOff()],
              ),
            ];
          },
          body: const TabBarView(
            children: [
              LearnPage(),
              TutorialPage(),
              OpeninPage(),
              ResourcesPage()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: TabBar(
          tabs: [
            _buildTab(Icons.text_increase_sharp, 0),
            _buildTab(Icons.book_outlined, 1),
            _buildTab(Icons.move_to_inbox_outlined, 2),
            _buildTab(Icons.text_snippet_outlined, 3),
          ],
          indicatorColor: Colors.white,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, int index) {
    return Tab(
      icon: Icon(
        icon,
        color: _selectedIndex == index
            ? Colors.white
            : const Color.fromARGB(255, 255, 165, 0),
      ),
    );
  }
}
