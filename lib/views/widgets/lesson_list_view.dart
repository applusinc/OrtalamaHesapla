import 'package:flutter/material.dart';
import 'package:ortalamahesapla/data/app_lessons.dart';
import 'package:ortalamahesapla/model/lesson.dart';

class LessonListView extends StatefulWidget {
  Lesson lesson;
  int index;
  Function onDismiss;
  LessonListView({super.key, required this.lesson, required this.index, required this.onDismiss});

  @override
  State<LessonListView> createState() => _LessonListViewState();
}

class _LessonListViewState extends State<LessonListView> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        AppLessons.derslerList.removeAt(widget.index);
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          child: ListTile(
            title: Text(widget.lesson.lessonName),
            leading: CircleAvatar(
              child: Text(widget.lesson.lessonScore.toString()),
            ),
            subtitle: Text("Ders Ağırlığı: ${widget.lesson.lessonHour}"),
          ),
        ),
      ),
    );
  }
}
