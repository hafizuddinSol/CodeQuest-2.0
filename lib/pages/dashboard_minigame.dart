import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardMiniGameApp extends StatelessWidget {
  const DashboardMiniGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Dashboard - Mini Games',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F4FF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DashboardMiniGamePage(
        teacherName: 'Ms. Nurul Natalia',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardMiniGamePage extends StatefulWidget {
  final String teacherName;
  const DashboardMiniGamePage({Key? key, required this.teacherName})
      : super(key: key);

  @override
  State<DashboardMiniGamePage> createState() => _DashboardMiniGamePageState();
}

class _DashboardMiniGamePageState extends State<DashboardMiniGamePage> {
  final int totalStudents = 28;
  final int totalGames = 7;
  final int activeSessions = 2;

  @override
  Widget build(BuildContext context) {
    final double cardRadius = 14.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        centerTitle: false,
        backgroundColor: const Color(0xFF3F51B5),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildStatsRow(),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: (MediaQuery.of(context).size.width > 600) ? 3 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3 / 2,
                  children: [
                    // 🔹 View Students Tile
                    _buildTile(
                      title: 'View Students',
                      icon: Icons.group,
                      color: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const StudentsPage()),
                      ),
                      radius: cardRadius,
                    ),
                    _buildTile(
                      title: 'Mini Games List',
                      icon: Icons.videogame_asset,
                      color: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MiniGamesListPage()),
                      ),
                      radius: cardRadius,
                    ),
                    _buildTile(
                      title: 'Add New Game',
                      icon: Icons.add_box,
                      color: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddNewGamePage()),
                      ),
                      radius: cardRadius,
                    ),
                    _buildTile(
                      title: 'Leaderboard',
                      icon: Icons.emoji_events,
                      color: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LeaderboardPage()),
                      ),
                      radius: cardRadius,
                    ),
                    _buildTile(
                      title: 'Settings',
                      icon: Icons.settings,
                      color: Colors.white,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      ),
                      radius: cardRadius,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: Text(
            widget.teacherName.isNotEmpty ? widget.teacherName[0] : 'T',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome,', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.teacherName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile clicked')),
                      );
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF3F51B5),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('Students', totalStudents.toString()),
        _buildStatCard('Games', totalGames.toString()),
        _buildStatCard('Active', activeSessions.toString()),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          child: Column(
            children: [
              Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              const SizedBox(height: 6),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required IconData icon,
    required Color color,
    String? subtitle,
    required VoidCallback onTap,
    double radius = 12.0,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFEEF1FF),
                child: Icon(icon, color: const Color(0xFF3F51B5)),
              ),
              const Spacer(),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              if (subtitle != null) ...[
                const SizedBox(height: 6),
                Text(subtitle, style: TextStyle(color: Colors.grey[600])),
              ],
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// 🔹 Students Page (from Firestore)
//
class StudentsPage extends StatelessWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersRef = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        backgroundColor: const Color(0xFF3F51B5),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No students found.'));
          }

          final students = snapshot.data!.docs;

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: students.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final student = students[index].data() as Map<String, dynamic>;
              final name = student['username'] ?? 'Unknown';
              final id = student['studentId']?.toString() ?? 'No ID';

              return ListTile(
                leading: CircleAvatar(child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?')),
                title: Text(name),
                subtitle: Text('ID: $id'),
                trailing: const Icon(Icons.chevron_right),
              );
            },
          );
        },
      ),
    );
  }
}

//
// 🔹 Other Stub Pages
//
class MiniGamesListPage extends StatelessWidget {
  const MiniGamesListPage({Key? key}) : super(key: key);

  final List<Map<String, String>> games = const [
    {'title': 'Spelling Sprint', 'desc': 'Spell words quickly'},
    {'title': 'Math Blitz', 'desc': 'Fast arithmetic drills'},
    {'title': 'Memory Match', 'desc': 'Pair matching memory game'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Games'), backgroundColor: const Color(0xFF3F51B5)),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: games.length,
        itemBuilder: (context, i) {
          final g = games[i];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.videogame_asset),
              title: Text(g['title']!),
              subtitle: Text(g['desc']!),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3F51B5)),
                child: const Text('Open'),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddNewGamePage extends StatefulWidget {
  const AddNewGamePage({Key? key}) : super(key: key);

  @override
  State<AddNewGamePage> createState() => _AddNewGamePageState();
}

class _AddNewGamePageState extends State<AddNewGamePage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String difficulty = 'Easy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Game'), backgroundColor: const Color(0xFF3F51B5)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Game Title'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter title' : null,
                onSaved: (v) => title = v ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                minLines: 2,
                maxLines: 4,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter description' : null,
                onSaved: (v) => description = v ?? '',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: difficulty,
                items: const [
                  DropdownMenuItem(value: 'Easy', child: Text('Easy')),
                  DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                  DropdownMenuItem(value: 'Hard', child: Text('Hard')),
                ],
                onChanged: (v) => setState(() => difficulty = v ?? 'Easy'),
                decoration: const InputDecoration(labelText: 'Difficulty'),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51B5),
                  minimumSize: const Size.fromHeight(44),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Game "$title" created (demo).')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Game'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> board = const [
    {'name': 'Ibrahim', 'score': 980},
    {'name': 'Aisyah', 'score': 940},
    {'name': 'Siti', 'score': 900},
    {'name': 'Hafiz', 'score': 860},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard'), backgroundColor: const Color(0xFF3F51B5)),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: board.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, idx) {
          final item = board[idx];
          return ListTile(
            leading: CircleAvatar(child: Text('${idx + 1}')),
            title: Text(item['name']),
            trailing: Text('${item['score']} pts'),
          );
        },
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: const Color(0xFF3F51B5)),
      body: ListView(
        children: [
          SwitchListTile(title: const Text('Show notifications'), value: true, onChanged: (v) {}),
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Light (default)'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Logged out (demo)')));
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
