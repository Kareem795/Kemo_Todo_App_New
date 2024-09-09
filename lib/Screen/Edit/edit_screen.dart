import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/Utils/app_Style.dart';
import 'package:kemo_todo_app_2/Utils/app_color.dart';
import 'package:kemo_todo_app_2/Utils/data_time_extension.dart';
import 'package:kemo_todo_app_2/models/task_model.dart';

class EditScreen extends StatefulWidget 
{
  static const String routeNamed = "Edit";

  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> 
{
  var selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text("To Do List"),
        centerTitle: true,
        backgroundColor: App_Colors.primary,
      ),

      body: Container
      (
        child: Stack
        (
          children: 
          [
          Column
          (
            children: 
            [
              buildbackgrond(),
              Expanded
              (
                flex: 75,
                child: Container
                (
                  color: App_Colors.bgColor,
                )
              )
            ],
          ),

          Padding
          (
            padding: const EdgeInsets.all(50.0),
            child: Container
            (
              height: 600,
              width: 300,
              decoration: BoxDecoration
              (
                color: Colors.white, borderRadius: BorderRadius.circular(25)
              ),

              child: Padding
              (
                padding: const EdgeInsets.all(15.0),
                child: Column
                (
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: 
                  [
                    const Text
                    (
                      "Edit Task",
                      textAlign: TextAlign.center,
                      style: App_Style.bottomSheetTitle,
                    ),

                    const SizedBox(height: 24,),

                    TextField
                    (
                      decoration:
                      const InputDecoration(hintText: "This is title"),
                      controller: titleController,
                    ),

                    const SizedBox(height: 30),

                    TextField
                    (
                      decoration: const InputDecoration(hintText: "Task details"),
                      controller: descriptionController,
                    ),

                    const SizedBox(height: 30,),

                    const Text
                    (
                      "Selected Data",
                      style: App_Style.bottomSheetTitle,
                    ),

                    const SizedBox(height: 20,),

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
                    
                    const SizedBox(height: 200,),

                    ElevatedButton
                    (
                      onPressed: () 
                      {
                        TaskModel task = TaskModel
                        (
                          title: titleController.text,
                          description: descriptionController.text,
                          date: DateUtils.dateOnly(selectedDate).microsecondsSinceEpoch
                        );
                        // FirebaseFunctions.editTask(task).then((value){
                        //   Navigator.pop(context);
                        // });
                      },
                      
                      child: Text
                      (
                        "Save Changes",
                        style: App_Style.normalGreyTextStyle.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: App_Colors.primary),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Expanded buildbackgrond() 
  {
    return Expanded
    (
      flex: 25,
      child: Stack
      (
        children: 
        [
          Column
          (
            children: 
            [
              Expanded
              (
                child: Container
                (
                  height: 100,
                  color: App_Colors.primary,
                )
              ),

              Expanded
              (
                child: Container
                (
                  color: App_Colors.bgColor,
                )
              ),
            ],
          ),
        ]
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
          colorScheme: const ColorScheme.light
          (
            primary: App_Colors.primary,
          )
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
