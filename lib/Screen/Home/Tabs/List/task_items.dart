import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kemo_todo_app_2/Utils/app_color.dart';
import 'package:kemo_todo_app_2/Firebase/firebase_functios.dart';
import 'package:kemo_todo_app_2/models/task_model.dart';

import '../../../Edit/edit_screen.dart';

class TaskItems extends StatefulWidget 
{
  TaskModel taskModel;

  TaskItems({super.key, required this.taskModel});

  @override
  State<TaskItems> createState() => _TaskItemsState();
}

class _TaskItemsState extends State<TaskItems> 
{
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) 
  {
    return InkWell
    (
      onTap: () 
      {
        Navigator.pushNamed(context, EditScreen.routeNamed);
      },
      child: Container
      (
        height: 115,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration
        (
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Slidable
        (
          startActionPane: ActionPane
          (
            motion: const DrawerMotion(),
            children: 
            [
              SlidableAction
              (
                onPressed: (context) 
                {
                  FirebaseFunctions.deleteTask(widget.taskModel.id);
                },
                label: "Delete",
                backgroundColor: Colors.red,
                icon: Icons.delete,
                spacing: 8,
                autoClose: true,
                padding: EdgeInsets.zero,
                borderRadius: const BorderRadius.only
                (
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),

              SlidableAction
              (
                onPressed: (context) 
                {
                  Navigator.pushNamed(context, EditScreen.routeNamed);
                },
                label: "Edit",
                backgroundColor: Colors.blue,
                icon: Icons.edit,
                spacing: 8,
                autoClose: true,
              )
            ],
          ),
          
          child: Padding
          (
            padding: const EdgeInsets.all(12.0),
            child: Row
            (
              children: 
              [
                Container
                (
                  height: 80,
                  width: 4,
                  decoration: BoxDecoration
                  (
                    color: widget.taskModel.isDone
                        ? Colors.greenAccent
                        : App_Colors.primary,
                    borderRadius: BorderRadius.circular(25)
                  ),
                ),

                const SizedBox(width: 12,),

                Expanded
                (
                  child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                    [
                      Text
                      (
                        widget.taskModel.title,
                        style: TextStyle
                        (
                          fontSize: 18,
                          color: widget.taskModel.isDone
                              ? Colors.greenAccent
                              : App_Colors.primary
                        ),
                      ),

                      Text
                      (
                        widget.taskModel.description,
                        style: const TextStyle
                        (
                          fontSize: 12, 
                          color: App_Colors.grey
                        )
                      )
                    ],
                  ),
                ),
                
                const SizedBox(width: 12,),

                widget.taskModel.isDone
                    ? const Text
                    (
                      "Done!",
                      style: TextStyle
                      (
                        fontSize: 22, 
                        color: Colors.greenAccent
                      ),
                    )
                    : ElevatedButton
                    (
                      onPressed: () 
                      {
                        widget. taskModel.isDone = true;
                        FirebaseFunctions.updateTask(widget.taskModel);
                      },
                      child: Icon
                      (
                        Icons.done,
                        color: widget.taskModel.isDone
                            ? Colors.greenAccent
                            : Colors.white,
                        size: 30,
                      ),
                      style: ElevatedButton.styleFrom
                      (
                        backgroundColor: App_Colors.primary,
                        shape: RoundedRectangleBorder
                        (
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
