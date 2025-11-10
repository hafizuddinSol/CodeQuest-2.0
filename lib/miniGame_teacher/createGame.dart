import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final _controller = TextEditingController();
  final FirebaseService _service = FirebaseService();
  final List<Map<String, String>> _questions = [];

  String question = '';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Mini Game')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Game Title'),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (v) => question = v,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            TextField(
              onChanged: (v) => answer = v,
              decoration: const InputDecoration(labelText: 'Answer'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _questions.add({'question': question, 'answer': answer});
                });
              },
              child: const Text('Add Question'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _questions
                    .map((q) => ListTile(
                  title: Text(q['question']!),
                  subtitle: Text('Answer: ${q['answer']}'),
                ))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _service.createGame(_controller.text, _questions);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Game created successfully!')),
                );
              },
              child: const Text('Save Game'),
            )
          ],
        ),
      ),
    );
  }
}
