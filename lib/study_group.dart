import 'package:flutter/material.dart';

// StudyGroup Class
class StudyGroup {
  String groupName;
  List<String> members;
  Color color;

  StudyGroup({
    required this.groupName,
    required this.members,
    required this.color,
  });
}

class StudyGroupScreen extends StatefulWidget {
  @override
  _StudyGroupScreenState createState() => _StudyGroupScreenState();
}

class _StudyGroupScreenState extends State<StudyGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _memberNameController = TextEditingController();
  List<StudyGroup> _groups = [];

  void _createGroup() {
    if (_groupNameController.text.isNotEmpty) {
      setState(() {
        _groups.add(StudyGroup(
          groupName: _groupNameController.text,
          members: [],
          color: Colors.teal,
        ));
        _groupNameController.clear();
      });
    }
  }

  void _addMember(int groupIndex) {
    if (_memberNameController.text.isNotEmpty) {
      setState(() {
        _groups[groupIndex].members.add(_memberNameController.text);
        _memberNameController.clear();
      });
    }
  }

  void _deleteGroup(int groupIndex) {
    setState(() {
      _groups.removeAt(groupIndex);
    });
  }

  void _goToChatScreen(StudyGroup group) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(group: group),
      ),
    );
  }

  void _joinGroup(BuildContext context, StudyGroup group) {
    final snackBar = SnackBar(content: Text("You have joined the group"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Groups'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: 'Enter Group Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createGroup,
              child: Text('Create Group'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _groups.length,
                itemBuilder: (context, groupIndex) {
                  StudyGroup group = _groups[groupIndex];

                  return GestureDetector(
                    onTap: () => _goToChatScreen(group),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      color: group.color,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.group, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              group.groupName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () => _joinGroup(context, group),
                              child: Text("Join Group"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.teal,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ],
                        ),
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

class ChatScreen extends StatefulWidget {
  final StudyGroup group;

  ChatScreen({required this.group});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _addMemberController = TextEditingController();
  List<String> _messages = [];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
        _messageController.clear();
      });
    }
  }

  void _addMember() {
    if (_addMemberController.text.isNotEmpty) {
      setState(() {
        widget.group.members.add(_addMemberController.text);
        _addMemberController.clear();
      });
    }
  }

  void _leaveGroup(BuildContext context) {
    Navigator.pop(context);
    final snackBar = SnackBar(content: Text("You have left the group"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.groupName),
        backgroundColor: Colors.teal,
        actions: [
          ElevatedButton(
            onPressed: () => _leaveGroup(context),
            child: Text(
              "Leave",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              elevation: 0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.teal[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Members:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ...widget.group.members.map((member) => Text(member)).toList(),
                SizedBox(height: 8),
                TextField(
                  controller: _addMemberController,
                  decoration: InputDecoration(
                    labelText: 'Add Member',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addMember,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send, color: Colors.teal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
