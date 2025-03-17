import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/course.dart';
import '../providers/courses_provider.dart';
import 'new_course_screen.dart';

const Color mainColor = Colors.blue;

class NewCourseListScreen extends StatelessWidget {
  const NewCourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void editCourse(Course course) async {
      await Navigator.of(context).push<Course>(
        MaterialPageRoute(builder: (ctx) => NewCourseScreen(course: course)),
      );
    }
    return Scaffold(
      appBar: AppBar(backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),),
      body: Consumer<CourseProvider>(
        builder: (context, provider, child){
          return ListView.builder(
              itemCount: provider.courses.length,
              itemBuilder: (context, index)=>
                Dismissible(key: Key(provider.courses[index].name),
                    onDismissed: (_) => provider.courses.removeAt(index),
                    child: CourseTile(course: provider.courses[index], onEdit: editCourse,
                    )
                ),
          );
        },
      ),
    );
  }
}


class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final Function(Course) onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average : $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            onTap: () => onEdit(course),
            title: Text(course.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(numberText), Text(averageText)],
            ),
          ),
        ),
      ),
    );
  }
}
