import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';

class TimelineTile extends StatelessWidget {
   TimelineTile({super.key, this.isFirst = false, this.isLast = false, this.isPast = false});  
  final bool isFirst;
  final bool isLast;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
  return TimelineTile(
    isFirst: isFirst,
    isLast: isLast,
    isPast: isPast,
  );
  }
}
