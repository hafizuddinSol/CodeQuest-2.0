import 'package:flutter/material.dart';
import '../widgets/notification_widget.dart';
import '../widgets/progress_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    widgets = [
      NotificationWidget(
        key: UniqueKey(),
        onRemove: () => _removeWidget(0),
      ),
      ProgressWidget(
        key: UniqueKey(),
        onRemove: () => _removeWidget(1),
      ),
    ];
  }

  void _removeWidget(int index) {
    setState(() {
      widgets.removeAt(index);
    });
  }

  void _addWidget(String type) {
    setState(() {
      final newIndex = widgets.length;
      if (type == 'notifications') {
        widgets.add(
          NotificationWidget(
            key: UniqueKey(),
            onRemove: () => _removeWidget(newIndex),
          ),
        );
      } else if (type == 'progress') {
        widgets.add(
          ProgressWidget(
            key: UniqueKey(),
            onRemove: () => _removeWidget(newIndex),
          ),
        );
      }
    });
    Navigator.pop(context);
  }

  void _showAddWidgetSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF424242),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF616161), width: 1),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Widget',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose a widget to add to your dashboard',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                const SizedBox(height: 20),
                _buildWidgetOption(
                  icon: Icons.notifications,
                  iconColor: Colors.blue,
                  title: 'Notifications',
                  description: 'View recent alerts and updates',
                  onTap: () => _addWidget('notifications'),
                ),
                const SizedBox(height: 12),
                _buildWidgetOption(
                  icon: Icons.trending_up,
                  iconColor: Colors.purple,
                  title: 'Progress Tracker',
                  description: 'Monitor project completion',
                  onTap: () => _addWidget('progress'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF616161)),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWidgetOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF616161),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFBDBDBD),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Pixel 5',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFBDBDBD),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FloatingActionButton(
              mini: true,
              onPressed: _showAddWidgetSheet,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, size: 24),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFF616161),
            height: 1,
          ),
        ),
      ),
      body: widgets.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF616161),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 32,
                      color: Color(0xFFBDBDBD),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No widgets added yet',
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _showAddWidgetSheet,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Your First Widget'),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: widgets[index],
          );
        },
      ),
    );
  }
}
