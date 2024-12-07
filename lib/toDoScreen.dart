import 'package:flutter/material.dart';
import 'package:todo/style.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  List<Map<String, dynamic>> todos = [];
  bool isediting = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          TextField(
            controller: nameController,
            decoration: MyInput("Name"),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: emailController,
            decoration: MyInput("Email"),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty &&
                  emailController.text.trim().isNotEmpty) {
                if (isediting) {
                  todos[currentIndex] = {
                    "name": nameController.text.trim(),
                    "email": emailController.text.trim()
                  };
                  isediting=false;
                } else {
                  todos.add({
                    "name": nameController.text.trim(),
                    "email": emailController.text.trim(),
                  });
                }

                nameController.text = '';
                emailController.text = '';

                setState(() {});
              }
            },
            child:  Text(isediting ?  'Update':'Save'),
            style: button(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Card(
                    child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 80,
                        child: Column(
                          children: [
                            Text(todos[index]['name']),
                            Text(todos[index]['email']),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 230,
                      ),
                      Expanded(
                        flex:50,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              todos.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          nameController.text = todos[index]['name'];
                          emailController.text = todos[index]['email'];
                          isediting = true;
                          currentIndex = index;
                          setState(() {

                          });
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}


