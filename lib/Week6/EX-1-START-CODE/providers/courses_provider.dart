import 'package:flutter/material.dart';
import 'package:week5/Week6/EX-1-START-CODE/repositories/courses_repository.dart';

import '../models/course.dart';


class CourseProvider extends ChangeNotifier{
  final CourseRepository repository;
  List<Course> _courses = [];
  CourseProvider({required this.repository}){
    fetchCourses();
  }
  List<Course> get courses => _courses;
  
  void fetchCourses(){
    _courses = repository.getCourses();
    notifyListeners();
  }
  Course getCourseFor(String courseId){
    return _courses.firstWhere((course)=> course.name == courseId);
  }
  void addCourse(Course course){
    _courses.add(course);
    notifyListeners();
  }
  void addScore(String courseId, CourseScore score){
    final course = getCourseFor(courseId);
    course.addScore(score);
    notifyListeners();
  }
}