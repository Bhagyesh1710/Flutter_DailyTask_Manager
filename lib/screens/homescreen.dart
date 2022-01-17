import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_dailytask/model/task.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _taskController;

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Task t = Task.fromString(_taskController.text);
    //prefs.setString('task', json.encode(t.getMap()) );
    //_taskController.text = '';
    String? tasks = prefs.getString('task');
    List list = (tasks==null) ? [] : json.decode(tasks);
    print(list);
    list.add(json.encode(t.getMap()));
    print(list);
    prefs.setString('task', json.encode(list));
    _taskController.text = '';
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _taskController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager',style: GoogleFonts.montserrat(),),
        centerTitle: true,
      ),
      body: Center(
        child: Text('No Task Added Yet'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Container(
            padding: const EdgeInsets.all(10.0),
            height: 500,
            color: Colors.blue[200],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Task',style:GoogleFonts.montserrat(color: Colors.white,fontSize: 20),),
                    GestureDetector(
                      onTap: ()=>Navigator.of(context).pop(),
                      child: Icon(Icons.close),
                    ),
                  ],

                ),
                Divider(
                  thickness: 1.2,
                ),
                SizedBox(height: 20.0,),
                TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.blue),

                  ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter Task',
                    hintStyle: GoogleFonts.montserrat(),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: MediaQuery.of(context).size.width,
                  //height: 200.0,
                  child: Row(

                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () => _taskController.text = '',
                            child: Text('Reset',
                              style: GoogleFonts.montserrat(color: Colors.black),)
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,

                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () => saveData(),
                            child: Text('Add',
                              style: GoogleFonts.montserrat(),)
                        ),
                      ),
                    ],
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