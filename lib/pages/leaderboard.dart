import 'package:flutter/material.dart';
import 'package:gambit/services/rankings.dart';

class LeaderPage extends StatelessWidget {
  const LeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Rankings();
  }
}

class Rankings extends StatelessWidget {
  const Rankings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cinematic.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: FutureBuilder<List<User>>(
        future: fetchLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return LeaderboardList(leaderboard: snapshot.data!);
          }
        },
      ),
    );
  }
}

class LeaderboardList extends StatelessWidget {
  final List<User> leaderboard;

  const LeaderboardList({super.key, required this.leaderboard});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        itemCount: leaderboard.length,
        itemBuilder: (context, index) {
          final user = leaderboard[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: index == 0
                  ? Border.all(
                      color: Colors.red, style: BorderStyle.solid, width: 4.5)
                  : Border.all(color: Colors.black),
              color: index == 0
                  ? Colors.amber
                  : index == 1
                      ? Colors.grey
                      : index == 2
                          ? Colors.brown
                          : Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${index + 1}.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                index == 0
                    ? Text('**${user.username}**',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 243, 5, 5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic))
                    : Text(user.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                Text('Rating: ${user.rating}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
