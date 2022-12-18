import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListItem extends StatelessWidget {
  final String taskName;
  final bool taskCompeted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ListItem(
      {super.key,
      required this.taskName,
      required this.taskCompeted,
      required this.onChanged,required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Checkbox(
                  value: taskCompeted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                Text(
                  taskName,
                  style: TextStyle(
                      decoration: taskCompeted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
