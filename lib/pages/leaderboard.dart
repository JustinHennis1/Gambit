import 'package:flutter/material.dart';
import 'package:gambit/pages/texttheme.dart';

class LeaderPage extends StatelessWidget {
  const LeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/back3.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.95),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextTheme1('Top 10'),
          const SizedBox(
              height: 10), // Add some spacing between text and leaderboard
          _buildLeaderboardTable(),
        ],
      ),
    );
  }

  Widget _buildLeaderboardTable() {
    // Example data for the leaderboard
    List<Map<String, dynamic>> leaderboardData = [
      {'Rank': 1, 'Player': 'Player 1', 'Rating': 2000},
      {'Rank': 2, 'Player': 'Player 2', 'Rating': 1950},
      {'Rank': 3, 'Player': 'Player 3', 'Rating': 1800},
      {'Rank': 4, 'Player': 'Player 4', 'Rating': 1700},
      {'Rank': 5, 'Player': 'Player 5', 'Rating': 1690},
      {'Rank': 6, 'Player': 'Player 6', 'Rating': 1450},
      {'Rank': 7, 'Player': 'Player 7', 'Rating': 1440},
      {'Rank': 8, 'Player': 'Player 8', 'Rating': 1300},
      {'Rank': 9, 'Player': 'Player 9', 'Rating': 1200},
      {'Rank': 10, 'Player': 'Player 10', 'Rating': 1200},
      // Add more entries as needed
    ];
    dynamic color1 = Colors.white;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Table(
            border: TableBorder.all(
                color: Colors.black, style: BorderStyle.values[0]),
            columnWidths: const {
              0: FractionColumnWidth(0.2),
              1: FractionColumnWidth(0.5),
              2: FractionColumnWidth(0.3),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Colors.red),
                children: ['Rank', 'Player', 'Rating'].map((header) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      header,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Young_Serif'),
                    ),
                  );
                }).toList(),
              ),
              for (var i = 0; i < leaderboardData.length; i++)
                TableRow(
                  decoration: i == 0
                      ? const BoxDecoration(
                          color: Colors.amber) // Gold for the first row
                      : i == 1
                          ? const BoxDecoration(
                              color: Colors.grey) // Silver for the second row
                          : i == 2
                              ? const BoxDecoration(
                                  color:
                                      Colors.brown) // Bronze for the third row
                              : const BoxDecoration(), // No decoration for the rest
                  children: ['Rank', 'Player', 'Rating'].map((field) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            TextTheme4(leaderboardData[i][field].toString()));
                  }).toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
