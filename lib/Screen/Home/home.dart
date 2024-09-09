import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/Screen/Add%20Bottom%20Shet/add_task_bottom_sheet.dart';
import 'package:kemo_todo_app_2/Screen/Home/Tabs/List/list.dart';
import 'package:kemo_todo_app_2/Screen/Home/Tabs/Settings/setting.dart';
import 'package:kemo_todo_app_2/Utils/app_color.dart';

class Home extends StatefulWidget 
{
  static const String routeNamed = "Home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> 
{
  int currentIndex = 0;
  List<Widget> tabs = [const ListTab(), const SettingsTab()];

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
        appBar: AppBar
        (
          title: const Text("To Do List"),
          backgroundColor: App_Colors.primary,
          centerTitle: true,
        ),

        body: tabs[currentIndex],

        backgroundColor: const Color.fromRGBO(221, 234, 217, 1.0),
        floatingActionButton: buildFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: buildbottomNavigationBar());
  }

  buildFab() => FloatingActionButton
  (
    onPressed: () 
    {
      Add_Bottom_Sheet.Show(context);
    },

    backgroundColor: App_Colors.primary,
    shape: const StadiumBorder
    (
      side: BorderSide(color: Colors.white, width: 3)
    ),
    child: const Icon(Icons.add),
  );

  buildbottomNavigationBar() => BottomAppBar
  (
    shape: const CircularNotchedRectangle(),
    color: Colors.white,
    notchMargin: 8,
    clipBehavior: Clip.hardEdge,
    padding: EdgeInsets.zero,
    child: BottomNavigationBar
    (
      elevation: 0,
      backgroundColor: Colors.transparent,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: currentIndex,
      onTap: (tappedIndex) 
      {
        currentIndex = tappedIndex;
        setState(() {});
      },
      items: const 
      [
        BottomNavigationBarItem
        (
          icon: Icon
          (
            Icons.list,
          ),
          label: "list"
        ),

        BottomNavigationBarItem
        (
          icon: Icon
          (
            Icons.settings,
          ),
          label: "settings"
        ),
      ]
    ),
  );
}
