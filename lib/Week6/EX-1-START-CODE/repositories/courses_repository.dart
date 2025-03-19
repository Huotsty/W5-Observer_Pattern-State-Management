import '../models/course.dart';

abstract class CourseRepository{
  List<Course> getCourses();
  void addScore(Course course, CourseScore score);
  void addCourse(Course course);
}