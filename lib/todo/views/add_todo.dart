import 'package:firebase_todos/components/custom_dropdown_textfield.dart';
import 'package:firebase_todos/components/custom_textfield.dart';
import 'package:firebase_todos/todo/todo_controller.dart';
import 'package:firebase_todos/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTodoScreen extends StatefulWidget {
  static const routeName = '/add_todo';

  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _key = GlobalKey<FormState>();
  final TodoController _todoController = TodoController.to;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  int _selectedReminder = 5;
  List<int> _reminderList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> _repeatList = ["None", "Daily"];

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
  }

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 20),
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blueGrey[500],
            colorScheme: ColorScheme.light(
              primary: Colors.blueGrey[500]!,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _date = picked;
        _dateController.value = TextEditingValue(
          text: DateFormat.yMMMMd().format(picked),
        );
      });
    }
  }

  void _selectTime({
    required TimeOfDay initialTime,
    required TextEditingController controller,
  }) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blueGrey[500],
            colorScheme: ColorScheme.light(
              primary: Colors.blueGrey[500]!,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        initialTime = picked;
        controller.value = TextEditingValue(
          text: picked.format(context),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                textCapitalization: TextCapitalization.sentences,
                controller: _titleController,
                hintText: 'Enter your title',
                validator: (value) => Validator.validateTitle(value),
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              const Text(
                'Note',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                textCapitalization: TextCapitalization.sentences,
                controller: _noteController,
                hintText: 'Enter your note',
                maxLines: null,
                validator: (value) => Validator.validateNote(value),
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                textCapitalization: TextCapitalization.sentences,
                controller: _dateController,
                hintText: 'Select your date',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Date is required' : null,
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF666666),
                ),
                readOnly: true,
                onTap: () => _selectDate(),
                onChanged: (value) {},
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Start Time',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: _startTimeController,
                          hintText: 'Select start time',
                          validator: (value) => value == null || value.isEmpty
                              ? 'Start time is required'
                              : null,
                          suffixIcon: const Icon(
                            Icons.access_time_rounded,
                            color: Color(0xFF666666),
                          ),
                          readOnly: true,
                          onTap: () => _selectTime(
                            initialTime: _startTime,
                            controller: _startTimeController,
                          ),
                          onChanged: (value) {},
                          inputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'End Time',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: _endTimeController,
                          hintText: 'Select end time',
                          maxLines: null,
                          validator: (value) => value == null || value.isEmpty
                              ? 'End time is required'
                              : null,
                          suffixIcon: const Icon(
                            Icons.access_time_rounded,
                            color: Color(0xFF666666),
                          ),
                          readOnly: true,
                          onTap: () => _selectTime(
                            initialTime: _endTime,
                            controller: _endTimeController,
                          ),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Remind',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              CustomDropdownTextField<int>(
                items: _reminderList
                    .map((reminder) => DropdownMenuItem<int>(
                          value: reminder,
                          child: Text('$reminder minutes early'),
                        ))
                    .toList(),
                onChanged: (value) {},
                value: _selectedReminder,
                hintText: 'Select period for reminder',
              ),
              const SizedBox(height: 20),
              const Text(
                'Repeat',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              CustomDropdownTextField<String>(
                items: _repeatList
                    .map((repeat) => DropdownMenuItem<String>(
                          value: repeat,
                          child: Text(repeat),
                        ))
                    .toList(),
                onChanged: (value) {},
                value: _selectedRepeat,
                hintText: 'Select when to repeat todo',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blueGrey[500],
                  foregroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                child: const Text('Create Todo'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
