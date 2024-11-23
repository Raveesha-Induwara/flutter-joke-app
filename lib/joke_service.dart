import 'package:dio/dio.dart';

class JokeService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://v2.jokeapi.dev/joke';

  Future<List<Map<String, dynamic>>> fetchJokesRaw() async {
    try {
      final response = await _dio.get('$baseUrl/programming',
          queryParameters: {
            'amount': 3,
            'type': 'single,twopart',
            'blacklistFlag': 'nsfw,religious,political,racist,sexist,explicit'
          },
      );

      if(response.statusCode == 200) {
        if(response.data['error'] == true) {
          throw Exception(response.data['message'] ?? 'Failed to fetch jokes');
        }

        final List<dynamic> jokeJson = response.data['jokes'];
        return jokeJson.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load jokes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching jokes: $e');
    }
  }
}
