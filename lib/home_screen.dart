import 'package:flutter/material.dart';
import 'add_class.dart'; // Import the Schedule Management Screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> phases = [
    {
      'title': 'Schedule Management',
      'icon': Icons.calendar_today,
      'color': Colors.blue,
    },
    {
      'title': 'Assignment Tracker',
      'icon': Icons.assignment,
      'color': Colors.green,
    },
    {
      'title': 'Study Groups',
      'icon': Icons.group,
      'color': Colors.orange,
    },
    {
      'title': 'Feedback System',
      'icon': Icons.feedback,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Life Assistant'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: phases.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (phases[index]['title'] == 'Schedule Management') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScheduleManagementScreen(),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: phases[index]['color'],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        phases[index]['icon'],
                        size: 48,
                        color: phases[index]['color'],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      phases[index]['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
