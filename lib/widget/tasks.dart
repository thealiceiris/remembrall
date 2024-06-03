// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:remembrall/models/task.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:remembrall/models/task_category.dart';
import 'package:remembrall/screens/detail/detail.dart';

// ignore: use_key_in_widget_constructors
class Tasks extends StatelessWidget {
  final taskList = TaskCategory.getTasks();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemCount: taskList.length,
          itemBuilder: (context, index) => taskList[index].isLast
              ? _buildAddtask()
              : _buildTask(context, taskList[index])),
    );
  }

  Widget _buildAddtask() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(20),
      dashPattern: const [10, 10],
      color: Colors.grey,
      child: const Center(
        child: Text(
          '+ Add Task',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTask(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(task: task),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: task.bgcolor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              task.iconData,
              color: task.iconColor!,
              size: 25,
            ),
            const SizedBox(height: 30),
            Text(
              task.title!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildTaskStatus(
                    task.iconColor!, task.textColor!, '${task.left}left'),
                const SizedBox(width: 5),
                _buildTaskStatus(
                    Colors.white, task.iconColor!, '${task.left}left'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatus(
    Color bgColor,
    Color textColor,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
