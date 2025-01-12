import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class AssignmentTrackerScreen extends StatefulWidget {
  @override
  _AssignmentTrackerScreenState createState() => _AssignmentTrackerScreenState();
}

class _AssignmentTrackerScreenState extends State<AssignmentTrackerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _assignmentNameController = TextEditingController();
  DateTime? _selectedDeadline;
  List<Map<String, dynamic>> _assignments = [];

  @override
  void initState() {
    super.initState();
  }

  void _selectDeadline() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDeadline = pickedDate;
      });
    }
  }

  void _addAssignment() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _assignments.add({
          'name': _assignmentNameController.text,
          'deadline': _selectedDeadline,
        });
        _assignmentNameController.clear();
        _selectedDeadline = null;
      });
    }
  }

  int _getMonthlyAssignmentCount() {
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    return _assignments.where((assignment) {
      final deadline = assignment['deadline'] as DateTime?;
      return deadline != null && deadline.month == currentMonth && deadline.year == currentYear;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Tracker'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _assignmentNameController,
                        decoration: InputDecoration(
                          labelText: 'Assignment Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the assignment name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedDeadline == null
                                  ? 'No deadline selected'
                                  : 'Deadline: ${DateFormat.yMMMd().format(_selectedDeadline!)}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _selectDeadline,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Select Deadline'),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: _addAssignment,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal, // Use 'backgroundColor' instead of 'primary'
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('Add Assignment'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Assignments this Month: ${_getMonthlyAssignmentCount()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _assignments.length,
                itemBuilder: (context, index) {
                  final assignment = _assignments[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        assignment['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Deadline: ${DateFormat.yMMMd().format(assignment['deadline'])}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: Icon(
                        Icons.check_circle,
                        color: Colors.teal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
