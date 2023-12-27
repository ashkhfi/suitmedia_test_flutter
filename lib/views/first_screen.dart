import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test_flutter/views/second_screen.dart';

import '../controllers/user_provider.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _palindromeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 142.h),
                width: 116.w,
                height: 116.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF97C8CC),
                ),
                child: const Icon(Icons.person_add_alt_1,
                    color: Colors.white, size: 40),
              ),
              Container(
                height: 47.h,
                margin: EdgeInsets.fromLTRB(32.w, 51.h, 32.w, 0),
                child: TextField(
                  maxLines: 1,
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(104, 103, 119, 0.36),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 20.w),
                    hintText: "Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              Container(
                height: 47.h,
                margin: EdgeInsets.fromLTRB(32.w, 15.h, 32.w, 0),
                child: TextField(
                  controller: _palindromeController,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(104, 103, 119, 0.36),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 20.w),
                    hintText: "Palindrome",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              // button check
              Container(
                height: 47.h,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(32.w, 45.h, 32.w, 0),
                child: ElevatedButton(
                  onPressed: () {
                    _cekPalindrome();
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
              // button next
              Container(
                height: 47.h,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(32.w, 15.h, 32.w, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    String name = _nameController.text;
                    userProvider.username = name;
                    if (name.isNotEmpty) {
                      userProvider.username = name;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondScreen(null)),
                      ).then((value) {
                        _nameController.clear();
                        _palindromeController.clear();
                      });
                    } else {
                      // Tampilkan pesan atau ambil tindakan yang sesuai jika nama kosong
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Warning'),
                            content: Text('Name cannot be empty.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B637B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(double.infinity, 47.h),
                  ),
                  child: Text(
                    'NEXT',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _cekPalindrome() {
    String text = _palindromeController.text.toLowerCase().replaceAll(" ", "");
    String reversedText = String.fromCharCodes(text.runes.toList().reversed);

    if (text == reversedText) {
      _showDialog('is Palindrome');
    } else {
      _showDialog('is not Palindrome');
    }
  }

  void _showDialog(String pesan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
