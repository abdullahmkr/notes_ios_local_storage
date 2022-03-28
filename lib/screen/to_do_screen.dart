import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/screen/add_item.dart';
import 'package:to_do_app/assets/text/app_text.dart';
import 'package:to_do_app/assets/text/head_line.dart';
import 'package:to_do_app/tasks.dart';
import '../functions.dart';
import 'detail_screen.dart';

late SharedPreferences prefs;

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
        accentColor: Colors.yellow[700],
      )),
      title: 'To Do Screen',
      home: _TodoScreen(),
    );
  }
}

List<Task> todoList = [];

String searchString = "";
List<FocusNode> _focusNodes = [
  FocusNode(),
  FocusNode(),
];

class _TodoScreen extends StatefulWidget {
  @override
  State<_TodoScreen> createState() => __TodoScreenState();
}

class __TodoScreenState extends State<_TodoScreen> {
  late Task todo;
  final myController = TextEditingController();

  void loadData() {
    List<String>? listString = prefs.getStringList('todoList');
    if (listString != null) {
      todoList =
          listString.map((item) => Task.fromMap(json.decode(item))).toList();
      setState(() {});
    }
  }

  void loadSharedPreferencesAndData() async {
    prefs = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  void initState() {
    loadSharedPreferencesAndData();
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  dismissItem(item) {
    if (todoList.contains(Task)) {
      setState(() {
        todoList.remove(Task);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white54,
        title: Align(
          alignment: AlignmentDirectional.topStart,
          child: HeadLine(
            text: 'Notes',
            size: 38,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddItem(),
                  ),
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: todoList.isNotEmpty //IF NOT EMPTY HOMEPAGE
          ? Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  //SEARCHBAR
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200]),
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 6.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              //SEARCHTEXT
                              controller: myController,
                              focusNode: _focusNodes[0],
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 5),
                                  hintText: "Search...",
                                  suffixIcon: _focusNodes[0].hasFocus &&
                                          searchString.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            setState(() {
                                              myController.clear();
                                              searchString = "";
                                              /* print(
                                                  "SearchString = $searchString");*/
                                            });
                                          })
                                      : IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () {}),
                                  border: InputBorder.none),
                              onChanged: (value) {
                                setState(() {
                                  searchString = value.toLowerCase();
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  //MAINLIST
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: ListView.separated(
                          itemCount: todoList.length,
                          itemBuilder: (context, index) {
                            final item = todoList[index];
                            return todoList[index]
                                    .headLine!
                                    .toLowerCase()
                                    .contains(searchString)
                                ? Dismissible(
                                    key: Key('${item.headLine}'),
                                    background: Container(
                                        child: const Align(
                                            alignment: Alignment.center,
                                            child: Text("Delete Item",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ))),
                                        color: Colors.red),
                                    child: ListTile(
                                      //LISTELEMENTS
                                      subtitle: Text("#${index + 1}",
                                          style: TextStyle(
                                              color: Colors.yellow[700])),
                                      title: Text(
                                          todoList[index].headLine.toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                          )),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                task: todoList[index]),
                                          ),
                                        );
                                      },
                                    ),
                                    onDismissed: (direction) {
                                      removeItem(item);
                                      setState(() {});
                                      (DismissDirection direction) {
                                        dismissItem(item.headLine);
                                      };
                                    })
                                : Container();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return todoList[index]
                                    .headLine!
                                    .toLowerCase()
                                    .contains(searchString)
                                ? const Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8.0),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  )
                                : Container();
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ]),
                        height: 60.0,
                        child: todoList.isNotEmpty
                            ? Center(
                                //BOTTOMBAR
                                child: Text(
                                "${todoList.length} Notes",
                                style: TextStyle(color: Colors.yellow[700]),
                              ))
                            : Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ])

          //IF EMPTY HOMEPAGE
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeadLine(text: "Nothing to do jet", color: Colors.blueGrey),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, top: 15.0),
                    child: AppText(text: "Let's go!", color: Colors.blueGrey),
                  ),
                  FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddItem(),
                          ),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
