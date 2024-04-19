// import 'dart:ffi';

import 'package:flutter/material.dart';

class Remembrall extends StatelessWidget {
  const Remembrall({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
                   ),
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),

                  ) ,
                ),
              ],
            ),
          )
      
        ],
      ),
     
    );
  }
}