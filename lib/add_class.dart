import 'package:flutter/material.dart';

class ScheduleManagementScreen extends StatefulWidget {
  const ScheduleManagementScreen({Key? key}) : super(key: key);

  @override
  _ScheduleManagementScreenState createState() => _ScheduleManagementScreenState();
}

class _ScheduleManagementScreenState extends State<ScheduleManagementScreen> {
  final List<Map<String, dynamic>> _schedule = [];

  void _showAddEditDialog({int? index, String? className, String? time, String? day}) {
    final TextEditingController classController = TextEditingController(text: className);
    final TextEditingController timeController = TextEditingController(text: time);
    final TextEditingController dayController = TextEditingController(text: day);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Class' : 'Edit Class'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: classController,
                decoration: const InputDecoration(labelText: 'Class Name'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
              TextField(
                controller: dayController,
                decoration: const InputDecoration(labelText: 'Day'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (index == null) {
                  setState(() {
                    _schedule.add({
                      'className': classController.text,
                      'time': timeController.text,
                      'day': dayController.text,
                    });
                  });
                } else {
                  setState(() {
                    _schedule[index] = {
                      'className': classController.text,
                      'time': timeController.text,
                      'day': dayController.text,
                    };
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
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
        title: const Text('Schedule Management'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _schedule.length,
        itemBuilder: (context, index) {
          final item = _schedule[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(item['className']),
              subtitle: Text('Time: ${item['time']} | Day: ${item['day']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showAddEditDialog(
                      index: index,
                      className: item['className'],
                      time: item['time'],
                      day: item['day'],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _schedule.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
