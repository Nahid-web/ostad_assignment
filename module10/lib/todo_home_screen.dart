import 'package:flutter/material.dart';


class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  InputDecoration borderStyle(text) {
    return InputDecoration(
      labelText: text,
      enabledBorder: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
    );
  }

  final tittleController = TextEditingController();
  final descriptionController = TextEditingController();

  TextEditingController editedTittleController = TextEditingController();
  TextEditingController editedDescriptionController = TextEditingController();

  List<Task> taskList = [];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.search,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //tittle
                      TextFormField(
                        controller: tittleController,
                        decoration: borderStyle('Add Tittle'),
                        validator: (value) {
                          if (value ==null || value.isEmpty ) {
                            return 'Enter a value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //description
                      TextFormField(
                        controller: descriptionController,
                        decoration: borderStyle('Add Description'),
                        validator: (value) {
                          if (value ==null || value.isEmpty ) {
                            return 'Enter a value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      // addButton
                      ElevatedButton(
                        onPressed: () {
                          taskList.add(
                            Task(
                                tittle: tittleController.text,
                                description: descriptionController.text),
                          );
                          setState(() {});
                        },
                        child: Text('add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                //edit button
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    editedTittleController.text = taskList[index].tittle;
                                    editedDescriptionController.text = taskList[index].description;
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          children: [
                                            //edit tittle
                                            TextField(
                                              controller: editedTittleController,
                                              decoration: borderStyle(''),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                            //edit description
                                            TextField(
                                              controller:editedDescriptionController,
                                              decoration: borderStyle(''),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                            // edit done Button
                                            ElevatedButton(
                                              onPressed: () {
                                                taskList[index].tittle = editedTittleController.text;
                                                taskList[index].description = editedDescriptionController.text;
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              child: Text('Edit Done'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Edit'),
                                ),
                                //delete button
                                TextButton(
                                  onPressed: () {
                                    taskList.removeAt(index);

                                    setState(() {

                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text((index + 1).toString())),
                    title: Text(taskList[index].tittle),
                    subtitle: Text(taskList[index].description),
                    trailing: Icon(Icons.arrow_right_alt),
                    selectedColor: Colors.red,
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

class Task {
  String tittle;

  String description;

  Task({
    required this.tittle,
    required this.description,
  });
}
