import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService _service = FirebaseService();

    return Scaffold(
      appBar: AppBar(title: const Text('Game Analytics')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _service.getAllResults(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('No results yet'));

          double avgScore = 0;
          Map<String, int> gameCount = {};

          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;
            avgScore += data['score'];
            gameCount[data['gameTitle']] =
                (gameCount[data['gameTitle']] ?? 0) + 1;
          }

          avgScore = avgScore / docs.length;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Average Score: ${avgScore.toStringAsFixed(2)}"),
                const SizedBox(height: 20),
                const Text("Games Played:"),
                ...gameCount.entries
                    .map((e) => Text("${e.key}: ${e.value} times"))
                    .toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
