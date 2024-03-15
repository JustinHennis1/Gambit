import 'package:flutter/material.dart';
import 'package:gambit/components/contain_image.dart';
import 'package:gambit/components/friendview.dart';
import 'package:gambit/components/neon_butt.dart';
import 'package:gambit/pages/social_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Precache the image synchronously
    precacheImage(const AssetImage('assets/images/back3.jpg'), context);

    return _buildHomePage(context);
  }

  Widget _buildHomePage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/back3.jpg'),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _page(context, constraints),
                const SizedBox(
                  height: 50,
                ),
                _page2(context, constraints),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _page(BuildContext context, BoxConstraints constraints) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight =
        screenHeight * 0.82; // Adjust the percentage as needed

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ContainImage(imagePath: 'assets/images/top.jpg', ht: containerHeight),
        Container(
          height: 100,
          width: 350,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                const Color.fromRGBO(255, 160, 0, 1).withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Friends(),
                Container(
                  height: 100,
                  width: 150,
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildAddFriendButton(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.07,
          right: 1,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NeonButt1("PLAY"),
            ],
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.02,
          left: -40,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NeonButt5("Puzzles"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddFriendButton(BuildContext context) {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: FloatingActionButton(
        onPressed: () {
          // Handle add friend button tap
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SocialPage()),
          );
        },
        backgroundColor: Colors.amber.shade700.withOpacity(0.9),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  Widget _page2(BuildContext context, BoxConstraints constraints) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight =
        screenHeight * 0.82; // Adjust the percentage as needed

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ContainImage(
            imagePath: 'assets/images/angleview.jpg', ht: containerHeight),
        Positioned(
          bottom: screenHeight * 0.07,
          right: -20,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NeonButt1("Events"),
            ],
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.02,
          left: -20,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NeonButt1("Game Modes"),
            ],
          ),
        ),
      ],
    );
  }
}
