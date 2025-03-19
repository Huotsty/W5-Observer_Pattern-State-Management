
import '../models/course.dart';
import 'courses_repository.dart';

class CourseMockRepository extends CourseRepository{
  final List<Course> _courses = [
    Course(name: 'Flutter'),
    Course(name: 'Data Science'),
    Course(name: 'Soft skills'),
  ];
  @override
  void addScore(Course course, CourseScore score) {
    course.addScore(score);
  }

  @override
  List<Course> getCourses() {
    return _courses;
  }
  
  @override
  void addCourse(Course course) {
    _courses.add(course);
  }
}