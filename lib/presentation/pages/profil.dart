import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_scraper_mobile/presentation/pages/deliveryAddress.dart';
import 'package:geo_scraper_mobile/presentation/pages/editPhoneNumber.dart';
import 'package:geo_scraper_mobile/presentation/pages/transactions.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      appBar: _buildAppBar(context),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            _userInfo(),
            _buildProfileSection([
              _buildProfileListItem("wallet", "Balans", () {}, "500 000 So`m"),
              const Divider(color: Color(0x203c486b), thickness: 1, height: 1),
              _buildProfileListItem("transaction", "Tranzaksiyalar", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Transactions()));
              }),
            ]),
            _buildProfileSection([
              _buildProfileListItem("marker-pin", "Mening manzillarim", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeliveryAddress()));
              }),
              const Divider(color: Color(0x203c486b), thickness: 1, height: 1),
              _buildProfileListItem("receipt", "Saqlanganlar", () {}),
            ]),
            _buildProfileSection([
              _buildProfileListItem("globe", "Qayta aloqa", () {}),
              const Divider(color: Color(0x203c486b), thickness: 1, height: 1),
              _buildProfileListItem("send", "Til", () {}),
              const Divider(color: Color(0x203c486b), thickness: 1, height: 1),
              _buildProfileListItem("faq", "Savol va javoblar", () {}),
            ]),
            _buildDeleteButton(),
            _buildLogoutButton(),
          ],
        )),
      )),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: const Text("Profile"),
      actions: [
        _buildPopupMenu(context),
      ],
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => EditPhoneNumber()));
        } else if (value == 2) {
          print("Выход нажат");
        }
      },
      itemBuilder: (_) => [
        _buildPopupMenuItem("phone", "Telefon raqamini tahrirlash", 1),
        const PopupMenuDivider(),
        _buildPopupMenuItem("edit", "Shaxsiy ma`lumotlarni tahrirlash", 2),
      ],
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(String icon, String title, int value) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          SvgPicture.asset("assets/icons/$icon.svg", width: 22),
          const SizedBox(width: 10),
          Text(title,
              style: const TextStyle(color: Color(0xff3c486b), fontSize: 14)),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Row(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0x103c486b),
              backgroundImage:
                  _imageFile != null ? FileImage(_imageFile!) : null,
              child: _imageFile == null
                  ? SvgPicture.asset("assets/icons/no-avatar.svg", width: 32)
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          _userDetails(),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1, color: const Color(0x203c486b)),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Column _userDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Eshonov Fakhriyor",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff3c486b))),
        Text("+998 94 124 22 02",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0x993c486b))),
      ],
    );
  }

  Widget _buildProfileSection(List<Widget> items) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: _boxDecoration(),
      child: Column(children: items),
    );
  }

  Widget _buildProfileListItem(String iconSvg, String title, VoidCallback onTap,
      [String? subtitle]) {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset("assets/icons/$iconSvg.svg", width: 24),
          title: Text(title,
              style: const TextStyle(fontSize: 22, color: Color(0x903c486b))),
          trailing: (subtitle?.isEmpty ?? true)
              ? const Icon(
                  Icons.chevron_right,
                  color: Color(0x903c486b),
                  size: 28,
                )
              : Text(
                  subtitle ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
          onTap: onTap,
        )
      ],
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.infinity,
      child: ElevatedButton(
        style: _buttonStyle(),
        onPressed: () {},
        child: const Text("Hisobni o`chirish",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff898e96))),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        child: const Text("Chiqish",
            style: TextStyle(
                fontSize: 18,
                color: Color(0xffff9556),
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      fixedSize: WidgetStateProperty.all(const Size.fromHeight(51)),
      backgroundColor: WidgetStateProperty.all(const Color(0xfff8f8fa)),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    );
  }
}
