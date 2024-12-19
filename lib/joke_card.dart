import 'package:flutter/material.dart';

class CardView {
  Card cardView(jokeJson) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // color: Colors.yellow,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              (jokeJson['type'] == 'single')
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const Text(
                            'Joke:  ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              '${jokeJson['joke']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ])
                  : Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Question:  ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  '${(jokeJson['setup'])}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ]),
                        const SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Answer:  ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  '${(jokeJson['delivery'])}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )
                            ])
                      ],
                    )
            ],
          )),
    );
  }
}
