import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class PlayGamePage extends StatefulWidget {
  final String studentName;
  final String gameTitle;

  const PlayGamePage({
    super.key,
    required this.studentName,
    required this.gameTitle,
  });

  @override
  State<PlayGamePage> createState() => _PlayGamePageState();
}

class _PlayGamePageState extends State<PlayGamePage> {
  final FirebaseService _firebaseService = FirebaseService();
  int score = 0;

  final List<String> items = ['CPU', 'RAM', 'SSD'];
  final List<String> targets = ['Processor', 'Memory', 'Storage'];
  Map<String, String?> matched = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.gameTitle)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            children: items.map((item) {
              return Draggable<String>(
                data: item,
                feedback: Chip(label: Text(item)),
                child: Chip(label: Text(item)),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            children: targets.map((target) {
              return DragTarget<String>(
                onAccept: (item) {
                  setState(() {
                    matched[item] = target;
                    if ((item == 'CPU' && target == 'Processor') ||
                        (item == 'RAM' && target == 'Memory') ||
                        (item == 'SSD' && target == 'Storage')) {
                      score += 10;
                    }
                  });
                },
                builder: (context, candidateData, rejectedData) => Chip(
                  label: Text(target),
                  backgroundColor: Colors.grey[300],
                ),
              );
            }).toList(),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              await _firebaseService.saveGameResult(
                name: widget.studentName,
                gameTitle: widget.gameTitle,
                score: score,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Score $score saved!')),
              );
            },
            child: const Text('Submit Result'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
