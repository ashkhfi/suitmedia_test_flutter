import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test_flutter/models/user_model.dart';
import 'package:suitmedia_test_flutter/views/third_screen.dart';

import '../controllers/user_provider.dart';

class SecondScreen extends StatefulWidget {
  final int? id;
  SecondScreen(this.id);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedUsername = "";
    UserProvider controller = Provider.of<UserProvider>(context);
    if (controller.userData.any((user) => user.id == widget.id)) {
      User user =
          controller.userData.firstWhere((user) => user.id == widget.id);
      selectedUsername = "${user.firstName} ${user.lastName}";
    } else {
      selectedUsername = "Selected User Name";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black), // Mengatur warna ikon back menjadi hitam
        title: const Text(
          "Second Screen",
          style: TextStyle(
              color: Colors.black), // Mengatur warna teks menjadi hitam
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 15.h, 0, 0),
            child: Text(
              "Welcome",
              style: GoogleFonts.poppins(
                textStyle:
                    TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 1.h, 0, 0),
            child: Text(
              controller.username,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  // color: Color.fromRGBO(104, 103, 119, 0.36),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 222.h),
              child: Text(
                selectedUsername,
                style: GoogleFonts.poppins(
                    fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            height: 47.h,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(32.w, 45.h, 32.w, 32.h),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B637B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: Size(double.infinity, 47.h),
              ),
              child: Text(
                'CHECK',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
