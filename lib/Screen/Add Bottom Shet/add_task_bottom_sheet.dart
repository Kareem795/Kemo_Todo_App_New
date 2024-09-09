import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/Utils/app_Style.dart';
import 'package:kemo_todo_app_2/Utils/app_color.dart';
import 'package:kemo_todo_app_2/Utils/data_time_extension.dart';
import 'package:kemo_todo_app_2/Firebase/firebase_functios.dart';
import 'package:kemo_todo_app_2/models/task_model.dart';

class Add_Bottom_Sheet extends StatefulWidget 
{
  static const String routeNmaed = "Add_Bottom_Sheet";

  const Add_Bottom_Sheet({super.key});

  @override
  State<Add_Bottom_Sheet> createState() => _Add_Bottom_SheetState();

  static void Show(BuildContext context) 
  {
    showModalBottomSheet
    (
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding
        (
          padding: EdgeInsets.only
          (
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const Add_Bottom_Sheet(),
        )
      );
  }
}

class _Add_Bottom_SheetState extends State<Add_Bottom_Sheet> 
{
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      // height: MediaQuery.of(context).size.height * 0.40,
      padding: const EdgeInsets.all(16),
      child: Column
      (
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: 
        [
          const Text
          (
            "Add New Task",
            textAlign: TextAlign.center,
            style: App_Style.bottomSheetTitle,
          ),

          const SizedBox(height: 24,),

          TextField
          (
            decoration: const InputDecoration(hintText: "Enter task title"),
            controller: titleController,
          ),

          const SizedBox(height: 12),

          TextField
          (
            decoration:
                const InputDecoration(hintText: "Enter task description"),
            controller: descriptionController,
          ),

          const SizedBox(height: 12),

          const Text
          (
            "Selected Data",
            style: App_Style.bottomSheetTitle,
          ),

          const SizedBox(height: 12),

          InkWell
          (
            onTap: () 
            {
              showMyDatePidker();
            },
            child: Text
            (
              selectedDate.toformattedDate,
              style: App_Style.normalGreyTextStyle.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            )
          ),

          const SizedBox(height: 20),
          
          ElevatedButton
          (
            onPressed:  () 
            {
              print(selectedDate);
              TaskModel task = TaskModel
              (
                title: titleController.text,
                description: descriptionController.text,
                date: DateUtils.dateOnly(selectedDate).microsecondsSinceEpoch
              );

              FirebaseFunctions.addTask(task)
              .then ( (value) { Navigator.pop(context); } );
            },

            child: Text
            (
              "Add",
              style: App_Style.normalGreyTextStyle.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: App_Colors.primary),
          )
        ],
      ),
    );
  }

  void showMyDatePidker() async 
  {
    selectedDate = await showDatePicker
    (
      context: context,
      builder: (context, child) => Theme
      (
        data: Theme.of(context).copyWith
        (
          colorScheme: ColorScheme.light(primary: App_Colors.primary,)
        ),
        child: child!,
      ),
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365))
    ) ?? selectedDate;
    setState(() {});
  }
}
