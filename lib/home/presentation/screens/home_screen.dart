import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/theme/app_text.dart';
import 'package:todo_app/core/validator/app_validator.dart';
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

  @override
  void initState() {
    super.initState();
    titleController.text = '';
    descriptionController.text = '';
    dateController.text = '';
    context.read<GetTodoCubit>().getTodo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    MediaQueryData screenSize = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          'assets/images/Group.svg',
          width: screenSize.size.width * 0.1,
          height: screenSize.size.height * 0.1,
        ),
        actions: [
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
                    child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DetailTodo.screenRoute);
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title', style: AppText.header),
                                SizedBox(height: 11),
                                Expanded(
                                  child: Text(
                                    'jbdlCWIHOI ULEHDIBD; D',
                                    style: AppText.body,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('12 Nov, 2022', style: AppText.subtitle),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: 4,
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
                          height: screenSize.size.height * 0.69,
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
                                        final formatted = DateFormat(
                                          'd MMMM, yyyy',
                                        ).format(pickedDate);
                                        setState(() {
                                          selectedDate = pickedDate;
                                          dateController.text = formatted;
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
                                      Navigator.pop(context);
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            try {
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
                                                    Timestamp.fromDate(
                                                      parsedDate,
                                                    ),
                                                  );
                                            } catch (e) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Invalid date format. Please choose a valid date.',
                                                    style: TextStyle(
                                                      fontFamily: "IBM",
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
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
    );
  }
}
