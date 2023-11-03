import 'package:flutter/material.dart';
import 'package:gambit/analytics/stats.dart';
import 'package:gambit/components/custom_tile.dart';
import 'package:gambit/components/start_logo.dart';
import 'package:gambit/analytics/analytic_pg.dart';
import 'package:gambit/pages/basescreen.dart';
import 'package:gambit/pages/history_pg.dart';
import 'package:gambit/learn/learn_page.dart';
import 'package:gambit/pages/social_page.dart';

//This tab bar will be for all analytical pages
//
//

class Control1 extends StatelessWidget {
  const Control1({super.key});
  @override
  Widget build(BuildContext context) {

      void getHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const BaseScreen(0)));
  }

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        width: 220,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color:
                        const Color.fromRGBO(255, 160, 0, 1).withOpacity(0.8),
                    backgroundBlendMode: BlendMode.colorBurn),
                child: const LogoBox(
                    imagePath: 'assets/images/prodigy1.png', logoHt: 200)),
            const CustomBorderTile(BaseScreen(0), 'Home ', null, Icons.home),
            
            const CustomBorderTile(
                BaseScreen(0), 'Settings ', null, Icons.settings),
  
            const CustomBorderTile(
                AnalyticPage(), 'Analytics ', 1, Icons.show_chart_rounded),
            
            const CustomBorderTile(
                HistoryPage(), 'History ', null, Icons.book_outlined),
            
            const CustomBorderTile(BaseScreen(2), 'Learn ', null, Icons.school),
            
            const CustomBorderTile(
                SocialPage(), 'Social ', null, Icons.people_alt_rounded),
            // Pressing this tile will diplay another logoff page incase it
            // was pressed accidentally
            const CustomBorderTile(
                null, 'Log Off ', null, Icons.logout_rounded),
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerboxisScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              centerTitle: true,
              title: SizedBox(
                height: 90,
                child: GestureDetector(onDoubleTap: getHome,child: const Image(image: AssetImage('assets/images/prodigy1.png'))),
              ), //TextTheme2("Gambit"),
              backgroundColor: Colors.black87,
              floating: false,
              //actions: [LogOff()],
            ),
          ];
        },
        body: const TabBarView(
          children: [AnalyticPage(), StatsPage()],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.black87,
        child: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.adjust_rounded)),
            Tab(icon: Icon(Icons.area_chart)),
          ],
        ),
      ),
    );
  }
}
