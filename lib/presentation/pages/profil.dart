import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0x203c486b)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0x103c486b),
                      backgroundImage:
                          _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? SvgPicture.asset(
                              "assets/icons/no-avatar.svg",
                              width: 32,
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Eshonov Fakhriyor",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff3c486b)),
                      ),
                      Text(
                        "+998 94 124 22 02",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0x993c486b)),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
