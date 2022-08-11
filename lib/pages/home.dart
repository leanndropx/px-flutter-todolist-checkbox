import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoController = TextEditingController();
  List toDoList = [];

  late Map<String, dynamic> lastRemovedTask;
  late int indexRemovedTask;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readData().then((data) {
      setState(() {
        toDoList = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(17, 1, 7, 1),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                        labelText: 'Add a task',
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                  onPressed: addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: toDoList.length,
                  itemBuilder: buildItem,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          deleteTask(index);
        },
        child: CheckboxListTile(
          title: Text(toDoList[index]['title']),
          value: toDoList[index]['ok'],
          onChanged: (value) {
            setState(() {
              toDoList[index]['ok'] = value;
              _saveData();
            });
          },
          secondary: CircleAvatar(
            child: Icon(toDoList[index]['ok'] ? Icons.check : Icons.error),
          ),
        ));
  }

  void addTask() {
    setState(() {
      Map<String, dynamic> newToDo = {};
      newToDo['title'] = todoController.text;
      todoController.text = "";
      newToDo['ok'] = false;
      toDoList.add(newToDo);
      _saveData();
    });
  }

  void deleteTask(int index){
    setState(() {
      lastRemovedTask = Map.from(toDoList[index]);
      indexRemovedTask = index;
      toDoList.removeAt(index);
      _saveData();
      undoTaskDeletion();

    });
  }

  void undoTaskDeletion(){
    final snack = SnackBar(
      content:
      Text('Task "${lastRemovedTask['title']}" successfully removed'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: (){
          setState(() {
            toDoList.insert(indexRemovedTask, lastRemovedTask);
            _saveData();
          });
        },
      ),
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      print(e);
      return "We found some problem to read the file";
    }
  }

  Future _refresh() async{
    setState(() {
      Future.delayed(const Duration(milliseconds: 20000));
      toDoList.sort((task1, task2){
        if (!task1['ok'] && task2['ok']) return -1;
        else if (task1['ok'] && !task2['ok']) return 1;
        else return 0;
      });
      _saveData();
    });
  }
}
