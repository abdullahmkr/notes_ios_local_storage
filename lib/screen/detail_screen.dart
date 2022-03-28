import 'package:flutter/material.dart';
import 'package:to_do_app/functions.dart';
import 'package:to_do_app/tasks.dart';
import 'package:to_do_app/screen/to_do_screen.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          accentColor: Colors.yellow[700],
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white54,
          title: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Notes',
                style: TextStyle(color: Colors.yellow[700]),
              )),
          leading: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      searchString = "";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoScreen()),
                      );
                    },
                    icon:
                        Icon(Icons.arrow_back_ios, color: Colors.yellow[700])),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: TextFormField(
                    initialValue: widget.task.headLine,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                    onChanged: (text) {
                      widget.task.headLine = text;
                      saveData();
                    },
                  ),
                ),
                Center(
                  child: TextFormField(
                    initialValue: widget.task.toDo,
                    showCursor: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      widget.task.toDo = text;
                      saveData();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
