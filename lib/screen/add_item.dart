import 'package:flutter/material.dart';
import 'package:to_do_app/screen/to_do_screen.dart';
import '../functions.dart';
import '../tasks.dart';

class AddItem extends StatelessWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add item',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          accentColor: Colors.yellow[700],
        ),
      ),
      home: const MyHomePage(title: 'Add a ToDo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String headLine = "";
  String toDo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white54,
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text("Done", style: TextStyle(color: Colors.yellow[700])),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    addItem(Task(headLine, toDo));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TodoScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.yellow[700])),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Center(
              child: TextField(
                // HEADLINE TEXTFIELD
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Headline",
                ),
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                onChanged: (text) {
                  headLine = text;
                },
              ),
            ),
            Center(
              child: TextField(
                // TODOTEXT TEXTFIELD
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  toDo = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
