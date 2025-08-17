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
    selectedDate = DateTime.now();
  }

  @override
  /// Builds the widget with a Scaffold that contains a AppBar with a leading
  /// SvgPicture, a body with a ListView of Todo items, and a FloatingActionButton
  /// that brings up a modal bottom sheet with a form for adding a new Todo item.
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    MediaQueryData screenSize = MediaQuery.of(context);
    return BlocProvider(
      create: (context) => GetTodoCubit()..getTodo(),
      child: Scaffold(
        appBar: AppBar(
          leading: SvgPicture.asset(
            'assets/images/Group.svg',
            width: screenSize.size.width * 0.1,
            height: screenSize.size.height * 0.1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                final currentLang = context.locale;
                if (currentLang.languageCode == 'en') {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(Locale('en'));
                }
              },
              child: Text(
                "language".tr(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            IconButton(
              icon: Icon(Icons.person_2_outlined, size: 30),
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.screenRoute);
              },
            ),
          ],
        ),
        body: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(height: screenSize.size.height * 0.02),
                    Expanded(
                      child: BlocConsumer<GetTodoCubit, GetTodoState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is GetTodoEmpty) {
                            Center(
                              child: Text(
                                'No_ToDo_yet_please_add_some!'.tr(),
                                style: AppText.body,
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
                            return ListView.separated(
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailTodo.screenRoute,
                                  );
                                },
                                splashColor: AppColors.white,
                                radius: 10,
                                child: Container(
                                  height: screenSize.size.height * 0.2,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.darkPink,
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
                                          "${DateFormat('d MMMM, yyyy').format(state.todos[index].date)}",
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
                            );
                          }
                          return Center();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return BlocProvider(
                          create: (context) => AddTodoCubit(),
                          child: Container(
                            height: screenSize.size.height * 0.79,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightPink,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: Form(
                              key: formKey,
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
                                  CustomTextFormField(
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        final pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1000),
                                          lastDate: DateTime(2100),
                                        );
                                        if (pickedDate != null) {
                                          final formattedDate = DateFormat(
                                            'd MMMM, yyyy',
                                          ).format(pickedDate);
                                          setState(() {
                                            selectedDate = pickedDate;
                                            dateController.text = formattedDate;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    label: dateController.text.isEmpty
                                        ? "Deadline"
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
                                  BlocConsumer<AddTodoCubit, AddTodoState>(
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
                                      } else if (state is AddTodoFailure) {
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
                                      return Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              Navigator.pop(context);

                                              final parsedDate =
                                                  dateController.text.isEmpty
                                                  ? selectedDate
                                                  : DateFormat(
                                                      'd MMMM, yyyy',
                                                    ).parse(
                                                      dateController.text,
                                                    );

                                              context
                                                  .read<AddTodoCubit>()
                                                  .addToDo(
                                                    titleController.text,
                                                    descriptionController.text,
                                                    parsedDate,
                                                  );
                                            }
                                            clearFields();
                                          },
                                          child: state is AddTodoLoading
                                              ? CircularProgressIndicator(
                                                  color: AppColors.lightPink,
                                                )
                                              : Text(
                                                  'Add ToDo',
                                                  style: TextStyle(
                                                    color: AppColors.lightPink,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "IBM",
                                                  ),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  backgroundColor: AppColors.darkPink,
                  child: Icon(Icons.add, size: 30),
                ),
              ),
              Positioned(
                bottom: 70,
                right: 10,
                child: FloatingActionButton(
                  heroTag: 'changeColorButton',
                  onPressed: () {},
                  backgroundColor: AppColors.darkPink,
                  child: Icon(Icons.color_lens_outlined, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
