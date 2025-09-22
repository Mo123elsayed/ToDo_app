import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/theme/app_text.dart';
import 'package:todo_app/home/presentation/controllers/add_to_do_cubit/add_todo_cubit.dart';
import 'package:todo_app/home/presentation/controllers/get_todo_cubit/get_todo_cubit.dart';
import 'package:todo_app/home/presentation/screens/detail_todo.dart';
import 'package:todo_app/home/presentation/screens/profile_screen.dart';
import 'package:todo_app/home/presentation/widgets/color_picker_widget.dart';
import 'package:todo_app/home/presentation/widgets/custom_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const screenRoute = '/todo-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  /// The color currently selected in the color picker.
  Color selectedColor = AppColors.lightPink;

  /// Navigates to the detail screen of a selected todo item.
  ///
  /// The function takes in the build context, the current state of the
  /// get todo cubit, and the index of the selected todo item. It uses
  /// the Navigator to push the detail screen onto the stack and passes
  /// the necessary arguments to the detail screen.
  void selectedToDo(BuildContext context, GetTodoSuccess state, int index) {
    Navigator.pushNamed(
      context,
      DetailTodo.screenRoute,
      arguments: {
        'id': state.todos[index].id,
        'title': state.todos[index].title,
        'description': state.todos[index].description,
        'date': state.todos[index].date,
        'color': state.todos[index].color,
      },
    );
  }

  /// Shows a warning dialog with the given message.
  Widget showWarningDialog(BuildContext context, String message) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }

  @override
  /// Initializes the state of the widget.
  ///
  /// Clears the text in the title, description, and date fields, and
  /// triggers the [GetTodoCubit] to get the todo list.
  void initState() {
    super.initState();
    titleController.text = '';
    descriptionController.text = '';
    dateController.text = '';
    context.read<GetTodoCubit>().getTodo();
  }

  /// Clears all fields and resets the selected date to the current date.
  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  @override
  /// Builds the widget with a Scaffold that contains a AppBar with a leading
  /// SvgPicture, a body with a ListView of Todo items, and a FloatingActionButton
  /// that brings up a modal bottom sheet with a form for adding a new Todo item.
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => GetTodoCubit()..getTodo(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/images/Group.svg',
              width: screenSize.width * 0.1,
              height: screenSize.height * 0.01,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreen.screenRoute);
                },
                child: CircleAvatar(
                  child: Icon(Icons.person_2_rounded, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
        body: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Center(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<GetTodoCubit, GetTodoState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is GetTodoEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  SvgPicture.asset(
                                    'assets/images/profile.svg',
                                    width: screenSize.width * 0.2,
                                    height: screenSize.height * 0.2,
                                  ),
                                ],
                              ),
                            );
                          }
                          if (state is GetTodoFailure) {
                            return showWarningDialog(
                              context,
                              'Failed_to_get_todo'.tr(),
                            );
                          }
                          if (state is GetTodoSuccess) {
                            return Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    selectedToDo(context, state, index);
                                  },
                                  splashColor: AppColors.white,
                                  radius: 10,
                                  child: Container(
                                    height: screenSize.height * 0.2,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 5.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: state.todos[index].color,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.todos[index].title,
                                            style: AppText.header,
                                          ),
                                          SizedBox(height: 11),
                                          Expanded(
                                            child: Text(
                                              state.todos[index].description,
                                              style: AppText.body,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            DateFormat(
                                              'd MMMM, yyyy',
                                            ).format(state.todos[index].date),
                                            style: AppText.subtitle,
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10),
                                itemCount: state.todos.length,
                              ),
                            );
                          }
                          return Center();
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 15,
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return BlocProvider(
                                create: (context) => AddTodoCubit(),
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selectedColor,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextFormField(
                                            label: 'title'.tr(),
                                            inputType: TextInputType.text,
                                            controller: titleController,
                                            secureText: false,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a title';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          CustomTextFormField(
                                            label: 'Description'.tr(),
                                            inputType: TextInputType.text,
                                            controller: descriptionController,
                                            maxLines: 14,
                                            secureText: false,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a description';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          CustomTextFormField(
                                            suffixIcon: IconButton(
                                              onPressed: () async {
                                                final pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1000),
                                                      lastDate: DateTime(2100),
                                                    );
                                                if (pickedDate != null) {
                                                  final formattedDate =
                                                      DateFormat(
                                                        'd MMMM, yyyy',
                                                      ).format(pickedDate);
                                                  setState(() {
                                                    selectedDate = pickedDate;
                                                    dateController.text =
                                                        formattedDate;
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            label: dateController.text.isEmpty
                                                ? "Deadline".tr()
                                                : dateController.text,
                                            inputType: TextInputType.datetime,
                                            controller: dateController,
                                            secureText: false,
                                            validator: (p0) {
                                              if (p0 == null || p0.isEmpty) {
                                                return 'Please enter a deadline';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          BlocConsumer<
                                            AddTodoCubit,
                                            AddTodoState
                                          >(
                                            listener: (context, state) {
                                              if (state is AddTodoSuccess) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'ToDo added successfully!',
                                                      style: TextStyle(
                                                        fontFamily: "IBM",
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else if (state
                                                  is AddTodoFailure) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Failed to add ToDo: ${state.errorMessage}',
                                                      style: TextStyle(
                                                        fontFamily: "IBM",
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            builder: (context, state) {
                                              /// this is the button that is used to add todo
                                              return Row(
                                                children: [
                                                  /// this is the button that is used to pick a color
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: AppColors.white,
                                                        width: 3,
                                                      ),
                                                      color: AppColors.white,
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return ColorPickerWidget(
                                                              initialColor:
                                                                  Colors.blue,
                                                              onColorSelected: (color) {
                                                                // Handle color selection
                                                                setState(() {
                                                                  selectedColor =
                                                                      color;
                                                                });
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .color_lens_rounded,
                                                        size: 35,
                                                        color: selectedColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.all(5),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              AppColors.white,
                                                          width: 3,
                                                        ),
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              30,
                                                            ),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          if (formKey
                                                              .currentState!
                                                              .validate()) {
                                                            final parsedDate =
                                                                dateController
                                                                    .text
                                                                    .isEmpty
                                                                ? selectedDate
                                                                : DateFormat(
                                                                    'd MMMM, yyyy',
                                                                  ).parse(
                                                                    dateController
                                                                        .text,
                                                                  );

                                                            context
                                                                .read<
                                                                  AddTodoCubit
                                                                >()
                                                                .addToDo(
                                                                  titleController
                                                                      .text,
                                                                  descriptionController
                                                                      .text,
                                                                  parsedDate,
                                                                  selectedColor,
                                                                );
                                                          }
                                                          clearFields();
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                        child:
                                                            state
                                                                is AddTodoLoading
                                                            ? CircularProgressIndicator(
                                                                color: AppColors
                                                                    .white,
                                                              )
                                                            : Text(
                                                                'Add_ToDo'.tr(),
                                                                style: TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "IBM",
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    backgroundColor: AppColors.lightPink,
                    child: Icon(Icons.add, size: 30),
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
