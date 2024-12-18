import 'package:flutter/material.dart';
import 'package:joke_app/cache.dart';
import 'joke_service.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const JokeListPage(),
    );
  }
}

class JokeListPage extends StatefulWidget {
  const JokeListPage({super.key});

  @override
  _JokeListPageState createState() => _JokeListPageState();
}

class _JokeListPageState extends State<JokeListPage> {
  final JokeService _jokeService = JokeService();
  final Cache _cache = Cache();
  List<Map<String, dynamic>> _jokesRaw = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cache.initPrefs();
  }

  // load jokes data from cache
  void getJokesData() {
    setState(() {
      _jokesRaw = _cache.getJokesData();
    });
  }

  Future<void> _fetchJokes() async {
    setState(() => _isLoading = true);
    try {
      _jokesRaw = await _jokeService.fetchJokesRaw();
      // save jokes data to cache
      _cache.saveJokesData(_jokesRaw);
      setState(() => _isLoading = false);
    } catch (e) {
      getJokesData();
      setState(() => _isLoading = false);
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Joke App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurple.shade100, Colors.white],
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to the Joke App!',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    shadows: [Shadow(color: Colors.white, blurRadius: 2)]
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Click the button to fetch random jokes!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {_fetchJokes();},
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.deepPurple),
                    minimumSize: WidgetStatePropertyAll<Size>(Size(0, 50)),
                    shape: WidgetStatePropertyAll(LinearBorder.none),
                    enableFeedback: true
                  ),
                  child: const Text(
                    'Fetch Jokes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
              const SizedBox(height: 24),
              Expanded(
                child: _isLoading ?
                const Center(child: CircularProgressIndicator())
                    : _buildJokeList(),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildJokeList() {
    if (_jokesRaw.isEmpty) {
      return const Center(
        child: Text(
          'No jokes fetched yet.',
          style: TextStyle(fontSize: 18, color: Colors.deepPurple),
        ),
      );
    }
    return ListView.builder(
      itemCount: _jokesRaw.length,
      itemBuilder: (context, index) {
        final jokeJson = _jokesRaw[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              jsonEncode(jokeJson),
              style: const TextStyle(fontSize: 14),
            )
          ),
        );
      },
    );
  }
}