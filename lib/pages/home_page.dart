import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/constants/database_constants.dart';
import 'package:todo/data/database.dart';
import 'package:todo/pages/pages_constants.dart';
import 'package:todo/util/background_container.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/my_drawer.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//list of todo task

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box(BOXNAME);
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get(LISTNAME) == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][LAST_VALUE_LIST] =
          !db.toDoList[index][LAST_VALUE_LIST];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    if (_controller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(child: Text('Atenção!')),

          content: Text('Por favor, insira o nome da tarefa.'),

          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),

                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APPTITLE),
        elevation: ELEVATION_HOME_PAGE,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/appbar_background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: BackgroundContainer(
        // ✅ UM SÓ body
        child: ListView.builder(
          // ListView vai DENTRO do BackgroundContainer
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.toDoList[index][FIRST_VALUE_LIST],
              taskCompleted: db.toDoList[index][LAST_VALUE_LIST],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
      ),
    );
  }
}
