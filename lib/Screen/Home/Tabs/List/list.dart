import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/Screen/Home/Tabs/List/task_items.dart';
import 'package:kemo_todo_app_2/Utils/app_Style.dart';
import 'package:kemo_todo_app_2/Utils/app_color.dart';
import 'package:kemo_todo_app_2/Utils/data_time_extension.dart';
import 'package:kemo_todo_app_2/Firebase/firebase_functios.dart';

class ListTab extends StatefulWidget 
{
  static const String routeNamed = "ListTab";

  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> 
{
  DateTime selectedCalenderDate = DateTime.now();

  @override
  Widget build(BuildContext context) 
  {
    return Column
    (
      children: 
      [
        buildCalender(),

        const SizedBox(height: 20,),

        Expanded
        (
          flex: 75,
          child: StreamBuilder
          (
            stream: FirebaseFunctions.getTask(selectedCalenderDate),
            builder: (context, snapshot) 
            {
              if (snapshot.connectionState == ConnectionState.waiting) 
              {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) 
              {
                return Center
                (
                  child: Column
                  (
                    children: 
                    [
                      const Text("Something went wrong"),
                      ElevatedButton
                      (
                        onPressed: () {}, 
                        child: const Text("try again")
                      )
                    ],
                  ),
                );
              }

              var tasks = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              // var tasks = snapshot.data?.docs.map((doc) => doc.data()).toList();
              if (tasks.isEmpty) 
              {
                return const Text("NoTasks");
              }
              return Expanded
              (
                // flex: 75,
                child: ListView.separated
                (
                  separatorBuilder: (context, index) => const SizedBox(height: 12,),

                  itemBuilder: (context, index) 
                  {
                    return TaskItems
                    (
                      taskModel: tasks[index],
                    );
                  },
                  itemCount: tasks.length,
                ),
              );
            },
          ),
        )
      ],
    );
  }

  buildCalender() 
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

          EasyInfiniteDateTimeLine
          (
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: selectedCalenderDate,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateChange: (selectedDate) {},
            itemBuilder: (context, date, inSelected, onDateTapped) 
            {
              return InkWell
              (
                onTap: () 
                {
                  setState(() 
                  {
                    selectedCalenderDate = date;
                  });
                },

                child: Container
                (
                  decoration: BoxDecoration
                  (
                    color: App_Colors.White,
                    borderRadius: BorderRadius.circular(22)
                  ),

                  child: Column
                  (
                    children: 
                    [
                      const Spacer(),

                      Text
                      (
                        date.dayName,
                        style: inSelected
                            ? App_Style.selectedCalenderDayStyle
                            : App_Style.unselectedCalenderDayStyle,
                      ),

                      const Spacer(),

                      Text
                      (
                        date.day.toString(),
                        style: inSelected
                            ? App_Style.selectedCalenderDayStyle
                            : App_Style.unselectedCalenderDayStyle,
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
// selectedCalenderDate = selectedDate;
// setState(() {});