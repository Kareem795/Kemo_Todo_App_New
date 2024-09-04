import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/UI/Utils/app_style.dart';
import 'package:kemo_todo_app_2/UI/Utils/data_time_extension.dart';

class Add_Bottom_Sheet extends StatefulWidget 
{
  Add_Bottom_Sheet({super.key});

  @override
  State<Add_Bottom_Sheet> createState() => _Add_Bottom_SheetState();

  static void Show(BuildContext context) 
  {
    showModalBottomSheet
    (
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding
      (
        padding: MediaQuery.of(context).viewInsets,
        child: Add_Bottom_Sheet(),
      )
    );
  }
}

class _Add_Bottom_SheetState extends State<Add_Bottom_Sheet> 
{
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(16),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: 
        [
          const Text
          (
            "Add new task",
            textAlign: TextAlign.center,
            style: App_Style.bottomSheetTitle,
          ),

          const SizedBox(height: 12,),

          const TextField
          (
            decoration: InputDecoration(hintText: "Enter task title"),
          ),

          const SizedBox(height: 12,),

          const TextField
          (
            decoration: InputDecoration(hintText: "Enter task description"),
          ),

          const SizedBox(height: 12,),

          Text
          (
            "selected data",
            style: App_Style.bottomSheetTitle.copyWith(fontSize: 16),
          ),

          const SizedBox(height: 12,),

          InkWell
          (
            onTap: () 
            {
              showMyDatePidker();
            },

            child: Text
            (
              selectedDate.toformattedDate,
              style: App_Style.normalGreyTextStyle,
              textAlign: TextAlign.center,
            )
          ),

          const Spacer(),

          ElevatedButton
          (
            onPressed: () {}, 
            child: const Text("Add")
          )

        ],
      ),
    );
  }


//! we create this function to control the date  
  void showMyDatePidker() async 
  {
    selectedDate = await showDatePicker
    (
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365))
    ) ?? selectedDate;
    setState(() {});
  }
}

