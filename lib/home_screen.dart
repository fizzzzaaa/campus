import 'package:flutter/material.dart';
import 'add_class.dart'; // Import the Schedule Management Screen
import 'assignment_tracker_screen.dart'; // Import the Assignment Tracker Screen
import 'study_group.dart'; // Import the Study Group Screen

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  // Sample data for courses and students
  final List<Map<String, dynamic>> courses = [
    {'name': 'Mathematics', 'students': 30},
    {'name': 'Physics', 'students': 25},
  ];

  // Sample data for professors and courses
  final List<Map<String, dynamic>> professors = [
    {'name': 'Dr. Ahmed', 'course': 'Mathematics'},
    {'name': 'Dr. Ali', 'course': 'Physics'},
  ];

  void _addCourse() {
    String courseName = '';
    String studentCount = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Course'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Course Name'),
                onChanged: (value) {
                  courseName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Student Count'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  studentCount = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (courseName.isNotEmpty && studentCount.isNotEmpty) {
                  setState(() {
                    courses.add({
                      'name': courseName,
                      'students': int.tryParse(studentCount) ?? 0,
                    });
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addProfessor() {
    String professorName = '';
    String courseName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Professor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Professor Name'),
                onChanged: (value) {
                  professorName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Course Name'),
                onChanged: (value) {
                  courseName = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (professorName.isNotEmpty && courseName.isNotEmpty) {
                  setState(() {
                    professors.add({
                      'name': professorName,
                      'course': courseName,
                    });
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

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
        child: Column(
          children: [
            Expanded(
              flex: 3,
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
                      } else if (phases[index]['title'] == 'Assignment Tracker') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssignmentTrackerScreen(),
                          ),
                        );
                      } else if (phases[index]['title'] == 'Study Groups') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudyGroupScreen(),
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
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  _buildTile(
                    title: 'Courses',
                    data: courses
                        .map((course) =>
                    '${course['name']}: ${course['students']} students')
                        .toList(),
                    color: Colors.blueAccent,
                    onAdd: _addCourse,
                  ),
                  const SizedBox(height: 16),
                  _buildTile(
                    title: 'Professors',
                    data: professors
                        .map((professor) =>
                    '${professor['name']}: ${professor['course']}')
                        .toList(),
                    color: Colors.deepPurpleAccent,
                    onAdd: _addProfessor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required List<String> data,
    required Color color,
    required VoidCallback onAdd,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: onAdd,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...data.map((item) {
            return Text(
              item,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
