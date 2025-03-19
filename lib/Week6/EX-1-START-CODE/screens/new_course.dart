import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:week5/Week6/EX-1-START-CODE/providers/courses_provider.dart';

import '../models/course.dart';


class NewCourse extends StatefulWidget {
  const NewCourse({super.key});

  @override
  State<NewCourse> createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  final _formKey = GlobalKey<FormState>();
  late String _enteredCourse;
  @override
  void initState() {
    super.initState();
    _enteredCourse = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Course')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredCourse = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  _formKey.currentState!.save();
                  // Call provider to add the course
                  Provider.of<CourseProvider>(
                    context,
                    listen: false,
                  ).addCourse(Course(name: _enteredCourse));
                  Navigator.of(context).pop();
                },
                child: const Text('Save Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
