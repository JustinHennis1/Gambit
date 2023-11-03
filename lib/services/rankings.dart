
import 'package:dio/dio.dart';

class User {
  final String username;
  final int rating;

  User({required this.username, required this.rating});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      rating: json['rating'],
    );
  }
}

Future<List<User>> fetchLeaderboard() async {
  final dio = Dio();
  const baseUrl = 'http://10.0.2.2:5000';

  try {
    final response = await dio.get('$baseUrl/get_all_users');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<User> leaderboard = data.map((json) => User.fromJson(json)).toList();
      return leaderboard;
    } else {
      throw Exception('Failed to load leaderboard');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
