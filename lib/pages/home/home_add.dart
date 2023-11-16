import 'package:flutter/material.dart';
import 'package:sqlitetodo/dblite/db_sqlite.dart';
import 'package:sqlitetodo/pages/navigator/nav.dart';

class HomeAddPage extends StatefulWidget {
  final int id;
  final String activity;
  final String description;
  final String time;
  final String day;
  const HomeAddPage(
      {super.key,
      required this.id,
      required this.activity,
      required this.description,
      required this.time,
      required this.day});

  @override
  State<HomeAddPage> createState() => _HomeAddPageState();
}

class _HomeAddPageState extends State<HomeAddPage> {
  final activityController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final dayController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    activityController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    dayController.dispose();
  }

  void onLoad() {
    activityController.text = widget.activity;
    descriptionController.text = widget.description;
    timeController.text = widget.time;
    dayController.text = widget.day;
  }

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: activityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Activity is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Activity", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Description", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: timeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Time is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Time", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dayController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Day is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Day", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        DatabaseHelper.instance.update({
                          "_id": widget.id,
                          "activity": activityController.text,
                          "description": descriptionController.text,
                          "time": timeController.text,
                          "day": dayController.text,
                          "isDone": 0
                        }, 3).then((value) => {
                              if (value > 0)
                                {
                                  activityController.clear(),
                                  descriptionController.clear(),
                                  timeController.clear(),
                                  dayController.clear(),
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NavigatorPage()))
                                }
                              else
                                {print("AAA")}
                            });
                      },
                      child: const Text("Save")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
