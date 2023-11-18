import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlitetodo/dblite/db_sqlite.dart';
import 'package:sqlitetodo/helper/notification.dart';
import 'package:sqlitetodo/helper/shared_pref.dart';
import 'package:sqlitetodo/models/todo_model.dart';
import 'package:sqlitetodo/pages/home/home_add.dart';
import 'package:sqlitetodo/pages/user/user_screen.dart';
import 'package:sqlitetodo/view_model/check_token_vm.dart';
import 'package:sqlitetodo/view_model/dblite_vm.dart';
import 'package:sqlitetodo/view_model/profile_vm.dart';
import 'package:sqlitetodo/view_model/todo_vm.dart';

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
  // SQLITE

  final titleController = TextEditingController();
  final descController = TextEditingController();
  // Api

  final formKey = GlobalKey<FormState>();
  // Move -> State Management
  // List<TodoModel> dataTodo = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Move -> State Management
      // loadDatabase();
      onLoad();
    });
  }

  void onLoad() {
    // final todoVM = Provider.of<DatabaseLiteViewModel>(context, listen: false);
    final todoApiVM = Provider.of<TodoViewModel>(context, listen: false);
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);

    //  Load API
    todoApiVM.fetchTodo();

    // Load DBLITE
    // todoVM.loadDatabase();

    // Load Profile
    profileVM.onLoadImageandName();
  }

  // Move -> State Management
  // void loadDatabase() async {
  //   dataTodo.clear();
  //   dataTodo.addAll(await DatabaseHelper.instance.queryAllRows());
  //   setState(() {});
  // }

  @override
  void dispose() {
    super.dispose();
    activityController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    dayController.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Input From API
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content:
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        TextFormField(
                          controller: titleController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: descController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Provider.of<TodoViewModel>(context, listen: false)
                                  .createTodo(
                                      title: titleController.text,
                                      desc: descController.text,
                                      onFailed: () {
                                        Provider.of<CheckTokenViewModel>(
                                                context,
                                                listen: false)
                                            .logout(context);
                                      });
                            },
                            child: Text("Submit"))
                      ]),
                    ));

            // Input DBLITE
            // showDialog(
            //     context: context,
            //     builder: (_) => AlertDialog(
            //           content: SingleChildScrollView(
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 5, right: 5),
            //               child: Form(
            //                 key: formKey,
            //                 child: Column(
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: [
            //                     const Text("Input Data",
            //                         style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 18)),
            //                     const SizedBox(
            //                       height: 30,
            //                     ),
            //                     SizedBox(
            //                       width: MediaQuery.of(context).size.width,
            //                       child: TextFormField(
            //                         controller: activityController,
            //                         validator: (value) {
            //                           if (value!.isEmpty) {
            //                             return "Activity is required";
            //                           }
            //                           return null;
            //                         },
            //                         decoration: const InputDecoration(
            //                             labelText: "Activity",
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     const SizedBox(
            //                       height: 10,
            //                     ),
            //                     SizedBox(
            //                       width: MediaQuery.of(context).size.width,
            //                       child: TextFormField(
            //                         controller: descriptionController,
            //                         validator: (value) {
            //                           if (value!.isEmpty) {
            //                             return "Description is required";
            //                           }
            //                           return null;
            //                         },
            //                         decoration: const InputDecoration(
            //                             labelText: "Description",
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     const SizedBox(
            //                       height: 10,
            //                     ),
            //                     SizedBox(
            //                       width: MediaQuery.of(context).size.width,
            //                       child: TextFormField(
            //                         controller: timeController,
            //                         validator: (value) {
            //                           if (value!.isEmpty) {
            //                             return "Time is required";
            //                           }
            //                           return null;
            //                         },
            //                         decoration: const InputDecoration(
            //                             labelText: "Time",
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     const SizedBox(
            //                       height: 10,
            //                     ),
            //                     SizedBox(
            //                       width: MediaQuery.of(context).size.width,
            //                       child: TextFormField(
            //                         controller: dayController,
            //                         validator: (value) {
            //                           if (value!.isEmpty) {
            //                             return "Day is required";
            //                           }
            //                           return null;
            //                         },
            //                         decoration: const InputDecoration(
            //                             labelText: "Day",
            //                             border: OutlineInputBorder()),
            //                       ),
            //                     ),
            //                     const SizedBox(
            //                       height: 10,
            //                     ),
            //                     SizedBox(
            //                       width: MediaQuery.of(context).size.width,
            //                       child: ElevatedButton(
            //                           style: ElevatedButton.styleFrom(
            //                               backgroundColor: Colors.redAccent),
            //                           onPressed: () {
            //                             if (formKey.currentState!.validate()) {
            //                               var data = TodoModel(
            //                                   activity: activityController.text,
            //                                   description:
            //                                       descriptionController.text,
            //                                   time: timeController.text,
            //                                   day: dayController.text,
            //                                   isDone: 0);

            //                               // === Insert
            //                               // DatabaseHelper.instance.insert({
            //                               //   "activity": activityController.text,
            //                               //   "description":
            //                               //       descriptionController.text,
            //                               //   "time": timeController.text,
            //                               //   "day": dayController.text,
            //                               //   "isDone": 0
            //                               // }).then((value) => {
            //                               //       if (value > 0)
            //                               //         {
            //                               //           Navigator.pop(context),
            //                               //           activityController.clear(),
            //                               //           descriptionController
            //                               //               .clear(),
            //                               //           timeController.clear(),
            //                               //           dayController.clear(),
            //                               //           loadDatabase(),
            //                               //           setState(() {})
            //                               //         }
            //                               //     });

            //                               // === Insert By Model
            //                               // DatabaseHelper.instance
            //                               //     .insertByModel(data)
            //                               //     .then((value) => {
            //                               //           if (value > 0)
            //                               //             {
            //                               //               Navigator.pop(context),
            //                               //               activityController
            //                               //                   .clear(),
            //                               //               descriptionController
            //                               //                   .clear(),
            //                               //               timeController.clear(),
            //                               //               dayController.clear(),
            //                               //               Provider.of<DatabaseLiteViewModel>(
            //                               //                       context,
            //                               //                       listen: false)
            //                               //                   .loadDatabase()
            //                               //             }
            //                               //         });

            //                               Provider.of<DatabaseLiteViewModel>(
            //                                       context,
            //                                       listen: false)
            //                                   .insertDataDB(data);
            //                             } else {
            //                               print("Error");
            //                             }
            //                           },
            //                           child: const Text("Save")),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ));
            NotificationService().showNotification("Test", "TESTTT NOTIFIKASI");
          },
          child: const Icon(Icons.add)),
      backgroundColor: const Color(0xff151515),
      body: Consumer<TodoViewModel>(builder: (context, todoApiVM, _) {
        return Consumer<ProfileViewModel>(builder: (context, profileVM, _) {
          return Consumer<DatabaseLiteViewModel>(builder: (context, dbVM, _) {
            return SingleChildScrollView(
              child: SafeArea(
                  child: Column(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserPage()));
                  },
                  child: ListTile(
                    title: Text(
                      "Hello,${profileVM.name}",
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
                        child: Text("A")),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: todoApiVM.dataTodo.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          leading: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(Icons.add, size: 24)),
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("TEST"),
                              Text(todoApiVM.dataTodo[i].title ?? ""),
                            ],
                          ),
                          subtitle:
                              Text(todoApiVM.dataTodo[i].description ?? ""),
                        ),
                      );
                    })

                // ====== Data from SQLITE
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: const BouncingScrollPhysics(),
                //     itemCount: dbVM.dataTodo.length,
                //     itemBuilder: (context, index) {
                //       if (dbVM.dataTodo.isEmpty) {
                //         return const Text("Data Kosong");
                //       } else {
                //         return Padding(
                //           padding: const EdgeInsets.only(left: 15, right: 15),
                //           child: Card(
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10)),
                //               color: const Color(0xff1B1B1B),
                //               child: InkWell(
                //                 onTap: () {
                //                   activityController.text =
                //                       dbVM.dataTodo[index].activity.toString();
                //                   descriptionController.text =
                //                       dbVM.dataTodo[index].description.toString();
                //                   timeController.text =
                //                       dbVM.dataTodo[index].time.toString();
                //                   dayController.text =
                //                       dbVM.dataTodo[index].day.toString();

                //                   Navigator.pushReplacement(
                //                       context,
                //                       MaterialPageRoute(
                //                           builder: (context) => HomeAddPage(
                //                               id: dbVM.dataTodo[index].id,
                //                               activity:
                //                                   dbVM.dataTodo[index].activity,
                //                               description: dbVM
                //                                   .dataTodo[index].description,
                //                               time: dbVM.dataTodo[index].time,
                //                               day: dbVM.dataTodo[index].day)));
                //                 },
                //                 child: ListTile(
                //                   title: Text(dbVM.dataTodo[index].activity,
                //                       style:
                //                           const TextStyle(color: Colors.white)),
                //                   subtitle: Text(
                //                     "${dbVM.dataTodo[index].description} - ${dbVM.dataTodo[index].time}",
                //                     style: const TextStyle(color: Colors.white),
                //                   ),
                //                   trailing: Row(
                //                       mainAxisSize: MainAxisSize.min,
                //                       children: [
                //                         IconButton(
                //                             onPressed: () {
                //                               DatabaseHelper.instance.update({
                //                                 "activity":
                //                                     dbVM.dataTodo[index].activity,
                //                                 "description": dbVM
                //                                     .dataTodo[index].description,
                //                                 "time": dbVM.dataTodo[index].time,
                //                                 "day": dbVM.dataTodo[index].day,
                //                                 "isDone":
                //                                     dbVM.dataTodo[index].isDone ==
                //                                             0
                //                                         ? 1
                //                                         : 0
                //                               }, dbVM.dataTodo[index].id).then(
                //                                   (value) => {
                //                                         if (value > 0)
                //                                           {dbVM.loadDatabase()}
                //                                       });
                //                             },
                //                             icon: Icon(
                //                               dbVM.dataTodo[index].isDone == 0
                //                                   ? Icons.check_box_outline_blank
                //                                   : Icons.check_box,
                //                               color: Colors.redAccent,
                //                             )),
                //                         // IconButton(
                //                         //     onPressed: () {
                //                         //       DatabaseHelper.instance
                //                         //           .delete(dataTodo[index].id)
                //                         //           .then((value) => {
                //                         //                 if (value > 0)
                //                         //                   {
                //                         //                     setState(() {
                //                         //                       loadDatabase();
                //                         //                     })
                //                         //                   }
                //                         //               });
                //                         //     },
                //                         //     icon: const Icon(
                //                         //       Icons.delete,
                //                         //       color: Colors.redAccent,
                //                         //     ))
                //                       ]),
                //                 ),
                //               )),
                //         );
                //       }
                //     })

                // ElevatedButton(
                //     onPressed: () async {
                //       // var token = await SharedPrefs.getToken("token_user");
                //       // print(token);

                //       // Provider.of<CheckTokenViewModel>(context, listen: false)
                //       //     .logout(context);
                //       showModalBottomSheet(
                //           context: context,
                //           builder: (_) => Container(
                //               height: 400,
                //               child: Column(children: [Text("Test modal")])));
                //     },
                //     child: Text("Trigger Check"))
              ])),
            );
          });
        });
      }),
    );
  }
}
