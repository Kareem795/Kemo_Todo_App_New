import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/UI/Utils/app_color.dart';
import 'package:kemo_todo_app_2/UI/Utils/app_style.dart';
import 'package:kemo_todo_app_2/UI/Utils/data_time_extension.dart';

class List_Tab extends StatefulWidget 
{
  const List_Tab({super.key});

  @override
  State<List_Tab> createState() => _List_TabState();
}

class _List_TabState extends State<List_Tab> 
{
  DateTime selecedCalenderDate = DateTime.now();

  @override
  Widget build(BuildContext context) 
  {
    return Column
    (
      children: 
      [
        buildCalender(),
        const Spacer(flex: 75,)
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
              //! we make two containers to make the background of 
              //! calendar be upper half blue and lower half white
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
              //! ----------------------------------
            ],
          ),

          EasyInfiniteDateTimeLine
          (
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: selecedCalenderDate,
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
                    selecedCalenderDate = date;
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