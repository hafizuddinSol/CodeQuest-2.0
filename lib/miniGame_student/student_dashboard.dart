import 'package:flutter/material.dart';
import 'playGame.dart';
import 'gameScore.dart';

class StudentDashboard extends StatelessWidget {
  final String studentName;

  // Default gameTitle for the student
  final String gameTitle;

  const StudentDashboard({
    super.key,
    required this.studentName,
    this.gameTitle = 'Drag Game', // default game
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Welcome, $studentName 👋",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlayGamePage(
                      studentName: studentName,
                      gameTitle: gameTitle,
                    ),
                  ),
                );
              },
              child: Text("🎮 Play $gameTitle"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScorePage(studentName: studentName),
                  ),
                );
              },
              child: const Text("📊 View My Scores"),
            ),
          ],
        ),
      ),
    );
  }
}
