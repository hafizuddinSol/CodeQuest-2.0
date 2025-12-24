import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAQ Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FAQPage(),
    );
  }
}

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  final List<Map<String, String>> faqs = const [
    {
      "question": "What is this project about?",
      "answer": "This project is a simple Flutter app to demonstrate an FAQ page using ExpansionTile widgets."
    },
    {
      "question": "How do I run the project?",
      "answer": "You can run this Flutter project using 'flutter run' in your terminal or your IDE."
    },
    {
      "question": "Can I contribute to this project?",
      "answer": "Yes! You can fork the repository and submit pull requests for improvements."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ Page"),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqs[index]['question']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faqs[index]['answer']!),
              )
            ],
          );
        },
      ),
    );
  }
}
