import 'package:flutter/material.dart';
import 'package:sqlitetodo/dblite/db_sqlite.dart';
import 'package:sqlitetodo/models/todo_model.dart';

class HomePageNoVM extends StatefulWidget {
  const HomePageNoVM({super.key});

  @override
  State<HomePageNoVM> createState() => _HomePageNoVMState();
}

class _HomePageNoVMState extends State<HomePageNoVM> {
  final activityController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final dayController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<TodoModel> dataTodo = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDatabase();
    });
  }

  void loadDatabase() async {
    dataTodo.clear();
    dataTodo.addAll(await DatabaseHelper.instance.queryAllRows());
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    activityController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    dayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Input Data",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: activityController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Activity is required";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: "Activity",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: descriptionController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Description is required";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: "Description",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: timeController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Time is required";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: "Time",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: dayController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Day is required";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: "Day",
                                        border: OutlineInputBorder()),
                                  ),
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
                                        if (formKey.currentState!.validate()) {
                                          DatabaseHelper.instance.insert({
                                            "activity": activityController.text,
                                            "description":
                                                descriptionController.text,
                                            "time": timeController.text,
                                            "day": dayController.text,
                                            "isDone": 0
                                          }).then((value) => {
                                                if (value > 0)
                                                  {
                                                    Navigator.pop(context),
                                                    activityController.clear(),
                                                    descriptionController
                                                        .clear(),
                                                    timeController.clear(),
                                                    dayController.clear(),
                                                    loadDatabase(),
                                                    setState(() {})
                                                  }
                                              });
                                        } else {
                                          print("Error");
                                        }
                                      },
                                      child: const Text("Save")),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
          },
          child: const Icon(Icons.add)),
      backgroundColor: const Color(0xff151515),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(children: [
          ListTile(
            title: const Text(
              "Hello, Dio Okta R",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            subtitle: const Text(
              "Welcome Back!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            trailing: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  "https://picsum.photos/200",
                  width: 50,
                  height: 50,
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: dataTodo.length,
              itemBuilder: (context, index) {
                if (dataTodo.isEmpty) {
                  return const Text("Data Kosong");
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: const Color(0xff1B1B1B),
                        child: InkWell(
                          onTap: () {
                            activityController.text =
                                dataTodo[index].activity.toString();
                            descriptionController.text =
                                dataTodo[index].description.toString();
                            timeController.text =
                                dataTodo[index].time.toString();
                            dayController.text = dataTodo[index].day.toString();
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      content: SingleChildScrollView(
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
                                                  labelText: "Activity",
                                                  border: OutlineInputBorder()),
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
                                                  labelText: "Description",
                                                  border: OutlineInputBorder()),
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
                                                  labelText: "Time",
                                                  border: OutlineInputBorder()),
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
                                                  labelText: "Day",
                                                  border: OutlineInputBorder()),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.redAccent),
                                                  onPressed: () {
                                                    DatabaseHelper.instance
                                                        .update({
                                                      "activity":
                                                          activityController
                                                              .text,
                                                      "description":
                                                          descriptionController
                                                              .text,
                                                      "time":
                                                          timeController.text,
                                                      "day": dayController.text,
                                                      "isDone": 0
                                                    }, dataTodo[index].id).then(
                                                            (value) => {
                                                                  if (value > 0)
                                                                    {
                                                                      Navigator.pop(
                                                                          context),
                                                                      activityController
                                                                          .clear(),
                                                                      descriptionController
                                                                          .clear(),
                                                                      timeController
                                                                          .clear(),
                                                                      dayController
                                                                          .clear(),
                                                                      loadDatabase(),
                                                                      setState(
                                                                          () {})
                                                                    }
                                                                });
                                                  },
                                                  child: const Text("Save")),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: ListTile(
                            title: Text(dataTodo[index].activity,
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(
                              "${dataTodo[index].description} - ${dataTodo[index].time}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                  onPressed: () {
                                    DatabaseHelper.instance.update({
                                      "activity": dataTodo[index].activity,
                                      "description":
                                          dataTodo[index].description,
                                      "time": dataTodo[index].time,
                                      "day": dataTodo[index].day,
                                      "isDone":
                                          dataTodo[index].isDone == 0 ? 1 : 0
                                    }, dataTodo[index].id).then((value) => {
                                          if (value > 0)
                                            {
                                              setState(() {
                                                loadDatabase();
                                              })
                                            }
                                        });
                                  },
                                  icon: Icon(
                                    dataTodo[index].isDone == 0
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box,
                                    color: Colors.redAccent,
                                  )),
                              // IconButton(
                              //     onPressed: () {
                              //       DatabaseHelper.instance
                              //           .delete(dataTodo[index].id)
                              //           .then((value) => {
                              //                 if (value > 0)
                              //                   {
                              //                     setState(() {
                              //                       loadDatabase();
                              //                     })
                              //                   }
                              //               });
                              //     },
                              //     icon: const Icon(
                              //       Icons.delete,
                              //       color: Colors.redAccent,
                              //     ))
                            ]),
                          ),
                        )),
                  );
                }
              })
        ])),
      ),
    );
  }
}
