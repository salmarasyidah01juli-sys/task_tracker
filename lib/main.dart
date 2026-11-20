import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TaskTrackerPage(),
  ));
}

class TaskTrackerPage extends StatefulWidget {
  const TaskTrackerPage({super.key});

  @override
  State<TaskTrackerPage> createState() => _TaskTrackerPageState();
}

class _TaskTrackerPageState extends State<TaskTrackerPage> {
  final TextEditingController _inputController = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];

  void _tambahTugas() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() {
      _tasks.add({'title': _inputController.text.trim(), 'isDone': false});
      _inputController.clear();
    });
  }

  void _centangTugas(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  void _hapusTugas(int index) {
    setState((){
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Task Tracker')),
      body: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: const InputDecoration(
                      hintText: 'Tulis tugas baru...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _tambahTugas,
                  child: const Text('Simpan'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task['isDone'],
                      onChanged: (_) => _centangTugas(index),
                    ),
                    title: Text(
                      task['title'],
                      style: TextStyle(
                        decoration: task['isDone']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _hapusTugas(index),
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

