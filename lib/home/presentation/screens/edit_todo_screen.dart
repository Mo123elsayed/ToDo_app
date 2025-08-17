import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/validator/app_validator.dart';
import 'package:todo_app/home/presentation/controllers/edit_todo_cubit/edit_todo_cubit.dart';
import 'package:todo_app/home/presentation/widgets/custom_text_form_field.dart';

class EditTodoScreen extends StatefulWidget {
  final Map<String, dynamic> todo;
  const EditTodoScreen({super.key, required this.todo});
  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.todo['id'];
    titleController.text = widget.todo['title'];
    descriptionController.text = widget.todo['description'];
    dateController.text = widget.todo['date'];
  }

  @override
  /// Builds a screen for editing a todo item
  ///
  /// The screen contains three form fields: title, description, and deadline.
  /// The deadline field is a date picker. The screen also contains a button
  /// to update the todo item.
  ///
  /// The screen uses the [EditTodoCubit] to update the todo item. The
  /// [EditTodoCubit] listens to the state of the form fields and updates the
  /// todo item when the button is pressed. If the update is successful, it
  /// navigates back to the previous screen and shows a success message. If
  /// the update fails, it shows an error message.
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => EditTodoCubit(),
      child: BlocConsumer<EditTodoCubit, EditTodoState>(
        listener: (context, state) {
          if (state is EditTodoFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Failed to update todo',
                  style: TextStyle(
                    fontFamily: "IBM",
                    fontSize: 20,
                    color: AppColors.red,
                  ),
                ),
              ),
            );
          }
          if (state is EditTodoSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Todo updated successfully',
                  style: TextStyle(
                    fontFamily: "IBM",
                    fontSize: 20,
                    color: AppColors.green,
                  ),
                ),
              ),
            );
            final updatedTodo = {
              'title': titleController.text,
              'description': descriptionController.text,
              'date': dateController.text,
            };
            Navigator.of(context).pop(updatedTodo);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              height: screenSize.height,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.lightPink,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'Title',
                    inputType: TextInputType.text,
                    controller: titleController,
                    secureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    label: 'Description',
                    inputType: TextInputType.text,
                    controller: descriptionController,
                    maxLines: 14,
                    secureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  /// The deadline field is a date picker.
                  CustomTextFormField(
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              dateController.text = DateFormat(
                                'd MMMM, yyyy',
                              ).format(value);
                            });
                          }
                        });
                        print(
                          "===================> dateController.text = ${dateController.text}",
                        );
                      },
                      icon: Icon(Icons.calendar_today, color: AppColors.white),
                    ),
                    label: dateController.text.isEmpty
                        ? "Deadline (optional)"
                        : dateController.text,
                    inputType: TextInputType.datetime,
                    controller: dateController,
                    secureText: false,
                    validator: (p0) => AppValidator.validateDate(p0),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        context.read<EditTodoCubit>().editTodo(
                          widget.todo['id'],
                          titleController.text,
                          descriptionController.text,
                          DateTime.parse(dateController.text),
                        );
                      },
                      child: state is EditTodoLoading
                          ? CircularProgressIndicator(
                              color: AppColors.lightPink,
                            )
                          : Text(
                              'Update ToDo',
                              style: TextStyle(
                                color: AppColors.lightPink,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "IBM",
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
