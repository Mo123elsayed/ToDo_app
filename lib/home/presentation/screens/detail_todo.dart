import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/theme/app_text.dart';
import 'package:todo_app/home/presentation/controllers/delete_todo_cubit/delete_todo_cubit.dart';
import 'package:todo_app/home/presentation/screens/edit_todo_screen.dart';

class DetailTodo extends StatefulWidget {
  const DetailTodo({super.key});
  static const String screenRoute = '/detail-todo';

  @override
  State<DetailTodo> createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailTodo> {
  /// Displays a confirmation dialog to the user and deletes the todo item if confirmed.
  ///
  /// The [todoId] parameter is the ID of the todo item to be deleted.
  ///
  /// Returns a [Future<void>] with no value.
  Future<void> confirmDeleteTodo(String todoId) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Todo'),
          content: Text('Are you sure you want to delete this todo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      // Proceed with the deletion
      context.read<DeleteTodoCubit>().deleteTodo(todoId);
    }
  }

  @override
  /// Builds a screen that displays a single todo item and allows for editing and
  /// deleting the todo item.
  Widget build(BuildContext context) {
    final todo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final todoDate = todo['date'];
    print("todoDate.runtimeType:================> ${todoDate.runtimeType}");
    final formattedDate = DateFormat('d MMMM, yyyy').format(todoDate);

    return BlocConsumer<DeleteTodoCubit, DeleteTodoState>(
      listener: (context, state) {
        if (state is DeleteTodoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Todo deleted successfully',
                style: TextStyle(
                  fontFamily: "IBM",
                  fontSize: 20,
                  color: AppColors.green,
                ),
              ),
            ),
          );
          Navigator.of(context).pop();
        }
        if (state is DeleteTodoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Failed to delete todo',
                style: TextStyle(
                  fontFamily: "IBM",
                  fontSize: 20,
                  color: AppColors.red,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: todo['color'],
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
                onPressed: () {
                  confirmDeleteTodo(todo['id']);
                  // Show a confirmation dialog before deleting
                },
              ),
            ],
          ),
          body: Container(
            color: todo['color'],
            child: Padding(
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
                  Center(
                    child: Text(formattedDate, style: AppText.subtitle),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
