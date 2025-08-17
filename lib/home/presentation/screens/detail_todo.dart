import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/app_text.dart';
import 'package:todo_app/home/presentation/screens/edit_todo_screen.dart';

class DetailTodo extends StatefulWidget {
  const DetailTodo({super.key});
  static const String screenRoute = '/detail-todo';

  @override
  State<DetailTodo> createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailTodo> {
  // final Map<String, dynamic> todo = {};

  @override
  Widget build(BuildContext context) {
    final todo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("=====================================> DocID = ${todo['date']}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              var res = await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return EditTodoScreen(todo: todo);
                },
              );
              setState(() {
                if (res != null) {
                  todo.addAll(res);
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('${todo['title']}', style: AppText.header),
            const SizedBox(height: 25),
            Expanded(
              child: Text('${todo['description']}', style: AppText.body),
            ),
            Center(child: Text('${todo['date']}', style: AppText.subtitle)),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
