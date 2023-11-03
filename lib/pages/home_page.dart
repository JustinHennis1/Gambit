import 'package:flutter/material.dart';
import 'package:gambit/components/contain_image.dart';
import 'package:gambit/components/friendview.dart';
import 'package:gambit/components/neon_butt.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Use FutureBuilder to load the image asynchronously
      future: precacheImage(
        const AssetImage('assets/images/back3.jpg'),
        context,
      ),
      builder: (context, snapshot) {
        // Check if the image has been loaded
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildHomePage(context);
        } else {
          // Image is still loading, show a placeholder or loading indicator
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/back3.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.15),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const ContainImage(imagePath: 'assets/images/top.jpg', ht: 650),
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
        const Positioned(
          bottom: 45,
          right: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NeonButt1("PLAY"),
            ],
          ),
        ),
        const Positioned(
          bottom: -20,
          left: -40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NeonButt1("Puzzles"),
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
        },
        backgroundColor: Colors.amber.shade700.withOpacity(0.9),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  Widget _page2(BuildContext context, BoxConstraints constraints) {
    return const Stack(
      alignment: Alignment.topCenter,
      children: [
        ContainImage(imagePath: 'assets/images/angleview.jpg', ht: 650),
        Positioned(
          bottom: 250,
          right: -20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NeonButt1("Events"),
            ],
          ),
        ),
        Positioned(
          bottom: 130,
          left: -20,
          child: Row(
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
