import 'package:flutter/material.dart';
import 'package:kemo_todo_app_2/UI/Screen/Add%20Bottom%20Shet/add_bottom_sheet.dart';
import 'package:kemo_todo_app_2/UI/Screen/Home/Tabs/List/list_tab.dart';
import 'package:kemo_todo_app_2/UI/Screen/Home/Tabs/Settings/settings_tab.dart';
import 'package:kemo_todo_app_2/UI/Utils/app_color.dart';

class Home extends StatefulWidget 
{
  static const String route_named = "Home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> 
{
  int currentIndex = 0;
  List<Widget> tabs = [const List_Tab(), const Settings_Tab()];

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text("To Do List"),
        elevation: 0,
      ),

      body: tabs[currentIndex],
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //! control the ( floatingActionButtonLocation ) place
      bottomNavigationBar: buildbottomNavigationBar(),
    );
  }

  Widget buildbottomNavigationBar() => BottomAppBar
  (
    //! the job of ( BottomAppBar ) is control the bottom 
    //!( floatingActionButtonLocation ) style on the bottom navigation bar
    
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar
        (
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
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "list"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "settings"),
          ]
        ),
      );

  buildFab() => FloatingActionButton
  (
    onPressed: () 
    {
      Add_Bottom_Sheet.Show(context);
    },

    backgroundColor: App_Colors.primary,
    shape: const StadiumBorder
    (
      side: BorderSide
      (
        color: App_Colors.White, 
        width: 3
      )
    ),

    child: const Icon(Icons.add),

  );
}