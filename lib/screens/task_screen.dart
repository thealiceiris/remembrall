import 'package:flutter/material.dart';
import 'package:remembrall/widget/remembrall.dart';
// import 'package:flutter/widgets.dart';
// import 'package:remembrall/widget/custom_scaffold.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:const Color.fromARGB(255, 241, 222, 245),
      appBar: _buildAppBar(),
      body:const Column(crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Remembrall()
          
        ],
        ),
       
     );
     
    
  }

  AppBar _buildAppBar() => AppBar(
       backgroundColor:const Color.fromARGB(255, 241, 222, 245),
       elevation: 0,
       title: const Row(
        children: [
          SizedBox( width: 40,),
          Text( 'Hi there!', style: TextStyle(color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold),),
        ],
        ),
      actions: const [
        Icon(
          Icons.more_vert,
          color: Colors.black,
          size: 40,
        )
      ],
      
     );
     
}
