// third_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/user_provider.dart';
import 'second_screen.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black), // Mengatur warna ikon back menjadi hitam
        title: const Text(
          "Third Screen",
          style: TextStyle(
              color: Colors.black), // Mengatur warna teks menjadi hitam
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: (controller.isLoading && controller.userData.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.userData.isEmpty
                ? const Center(
                    child: Text('Data Empty'),
                  )
                : ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(20.0),
                itemCount: controller.userData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          "${controller.userData[index].firstName} ${controller.userData[index].lastName}" ,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        subtitle: Text(
                          controller.userData[index].email,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(104, 103, 119, 1)),
                        ),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(controller.userData[index].avatar),
                        ),
                        onTap: () {
                          int id = controller.userData[index].id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SecondScreen(id),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: Color.fromRGBO(226, 227, 228, 1),
                        height: 1.0,
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
