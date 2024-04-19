import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:remembrall/widget/custom_scaffold.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
       title: Row(
        children: [
          SizedBox(
            height: 45,
            width:45,
            child: ClipRRect(
              borderRadius:BorderRadius.circular(10)
              
           ),
          )
        ],
        ),
       iconTheme: const IconThemeData(color: Colors.white),
     ),
     
    );
  }
}
