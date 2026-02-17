import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

    // ADD TASK
  void addTask() {
    if (controller.text.isNotEmpty) {
      setState(() {
        tasks.add({'title': controller.text, 'completed': false});
      });
      controller.clear();
      saveTasks();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My To-Do List"), centerTitle: true),
      body: Column(
        children: [
          // INPUT FIELD
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Enter new task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
      void toggleTask(int index, bool? value) {
        setState(() {
         tasks[index]['completed'] = value;
    });
    saveTasks();
  }


                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: addTask, child: Text("ADD")),
              ],
            ),
          ),

          // TASK LIST
          Expanded(
            child: tasks.isEmpty
                ? Center(
                    child: Text("No tasks yet", style: TextStyle(fontSize: 18)),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListTile(
                          // TASK TITLE
                          title: Text(
                            tasks[index]['title'],
                            style: TextStyle(
                              fontSize: 18,
                              decoration: tasks[index]['completed']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),

                          // CHECKBOX
                          leading: Checkbox(
                            value: tasks[index]['completed'],
                            onChanged: (value) {
                              toggleTask(index, value);
                            },
                          ),

                          // DELETE BUTTON
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteTask(index);
                            },
                              // LOAD TASKS LOCALLY
          void loadTasks() async {
          final prefs = await SharedPreferences.getInstance();
         String? data = prefs.getString('tasks');

         if (data != null) {
          setState(() {
        tasks = List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    }
  }

 
          ),
        ],
      ),
    );
  }
}
