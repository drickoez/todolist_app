import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../database/database_helper.dart';
import './done_tasks_screen.dart';

class PendingTasksScreen extends StatefulWidget {
  const PendingTasksScreen({super.key});

  @override
  State<PendingTasksScreen> createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  static final _newFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    HomeController.tasks = DatabaseHelper.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black.withOpacity(0.5),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text("Todo App",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            ListTile(
              tileColor: Colors.blue[100],
              leading: const Icon(
                Icons.pending_actions_rounded,
                color: Colors.blue,
                size: 28,
              ),
              title: const Text(
                "Pending",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                Get.offAll(() => (const PendingTasksScreen()));
              },
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            ListTile(
              tileColor: Colors.blue[100],
              leading: const Icon(
                Icons.done_outline_rounded,
                color: Colors.blue,
                size: 28,
              ),
              title: const Text(
                "Done",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                Get.offAll(const DoneTasksScreen());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.purple),
        title: const Text("Todo App",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            )),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 40,
        onPressed: () => const Text('yes'),
        label: const Text("Add New Task"),
        icon: const Icon(Icons.task),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.017, horizontal: Get.width * 0.05),
              child: const Text(
                "Pending Tasks",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Divider(
              color: Colors.blue,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            FutureBuilder(
                future: HomeController.getPendingTasks(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Text(
                            "No Tasks",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Text(
                            "Tap on button to add new task",
                            style: TextStyle(
                              color: Colors.blue[300],
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              int todoId = snapshot.data![index].id!.toInt();
                              String todoTitle =
                                  snapshot.data![index].title!.toString();
                              String todoDescription =
                                  snapshot.data![index].description!.toString();
                              String todoDate =
                                  snapshot.data![index].date!.toString();
                              String todoTime =
                                  snapshot.data![index].time!.toString();

                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Dismissible(
                                  key: ValueKey<int>(todoId),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (DismissDirection direction) {
                                    setState(() {
                                      HomeController.updateTaskStatus(
                                          todoId, todoTitle, todoDescription);
                                      DatabaseHelper.getTasks();
                                      snapshot.data!
                                          .remove(snapshot.data![index]);
                                    });
                                  },
                                  background: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 16.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.done_outline_rounded,
                                                color: Colors.white),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Mark as Done",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
