import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_scraper_mobile/core/services/auth_service.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/pages/deliveryAddress.dart';
import 'package:geo_scraper_mobile/presentation/pages/editPhoneNumber.dart';
import 'package:geo_scraper_mobile/presentation/pages/favorites.dart';
import 'package:geo_scraper_mobile/presentation/pages/login.dart';
import 'package:geo_scraper_mobile/presentation/pages/send_otp.dart';
import 'package:geo_scraper_mobile/presentation/pages/transactions.dart';
import 'package:geo_scraper_mobile/presentation/utils/phone_number_format_with_space.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  int? selectedIndex = 0;

  List<String> languages = ["Ozbekcha", "Русский"];

  List<Map<String, dynamic>> user = [];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    List<Map<String, dynamic>> fetchedUser =
        await StorageService.getDataFromLocal(StorageType.userInfo);

    setState(() {
      user = fetchedUser;
    });

    print(user);
  }

  Future<void> onLogout() async {
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();

    await firebaseAuthService.logout();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

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
            SizedBox(height: 16),
            Visibility(
                visible: true,
                child: Column(
                  spacing: 16,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 36,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          spacing: 6,
                          children: [
                            Icon(Icons.info_outline, color: Colors.red),
                            Expanded(
                                child: Text(
                              "Telefon raqam tasdiqlanmagan !",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.red),
                            ))
                          ],
                        )),
                    CustomButton(
                        text: "Tasdiqlash",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SendOtp(
                                        isLogged: true,
                                      )));
                        },
                        type: CustomButtonType.outline)
                  ],
                )),
            _buildProfileSection([
              // _buildProfileListItem("wallet", "Balans", () {}, "500 000 So`m"),
              // const Divider(color: Color(0x203c486b), thickness: 1, height: 1),
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
              _buildProfileListItem("receipt", "Saqlanganlar", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Favorites()));
              }),
            ]),
            _buildProfileSection([
              _buildProfileListItem("globe", "Qayta aloqa",
                  () => _openFeedBackBottomDrawer(context)),
              const Divider(color: Color(0x203c486b), thickness: 1, height: 1),
              _buildProfileListItem(
                  "send", "Til", () => _openLanguageBottomDrawer(context)),
              // const Divider(color: Color(0x203c486b), thickness: 1, height: 1),
              // _buildProfileListItem("faq", "Savol va javoblar", () {}),
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
      children: [
        Text(
            "${user.isNotEmpty ? user[0]["username"] : ""} ${user.isNotEmpty ? user[0]["surname"] : ""}",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff3c486b))),
        Row(
          spacing: 6,
          children: [
            Icon(Icons.verified, color: Colors.blue, size: 20),
            Text(
                user.isNotEmpty
                    ? formatPhoneNumberWithSpace(user[0]["phoneNumber"])
                    : "",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0x993c486b))),
          ],
        ),
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
        onPressed: () => _showAlertDialog(
            context,
            "x-close.svg",
            "Akkauntni O`chirmoqchimisiz?",
            "O`chirish tugmachasini bosish orqali siz hisobingizni tiklash imkonyatisiz butunlay o`chirib tashlaysiz.",
            () {},
            "O`chirish"),
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
        onPressed: () => _showAlertDialog(
            context,
            "exit.svg",
            "Hisobdan chiqish",
            "Siz haqiqatdan ham chiqishni xoxlaysizmi?",
            onLogout,
            "Chiqish"),
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

  void _openLanguageBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tilni tanlang',
                  style: TextStyle(color: Color(0xff3c486b), fontSize: 24),
                ),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(languages.length, (i) {
                    return CheckboxListTile(
                      checkColor: Colors.amber,
                      activeColor: Colors.transparent,
                      side: BorderSide(color: Colors.transparent),
                      title: Text(languages[i],
                          style: TextStyle(
                              color: Color(0xff3c486b), fontSize: 16)),
                      value: selectedIndex == i,
                      onChanged: (bool? value) {
                        setState(() {
                          selectedIndex = i;
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openFeedBackBottomDrawer(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return SizedBox(
                width: double.infinity,
                height: 182,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Qayta aloqa',
                          style:
                              TextStyle(color: Color(0xff3c486b), fontSize: 24),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/phone.svg",
                                  color: Color(0xff3c486b),
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: 10),
                                Text("Qo`ng`iroq",
                                    style: TextStyle(
                                        color: Color(0xff3c486b), fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                            color: Color(0x203c486b), height: 1, thickness: 1),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/send.svg",
                                  color: Color(0xff3c486b),
                                  height: 24,
                                  width: 24,
                                ),
                                SizedBox(width: 10),
                                Text("Telegramda yozing",
                                    style: TextStyle(
                                        color: Color(0xff3c486b), fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            }));
  }

  void _showAlertDialog(BuildContext context, String svg, String title,
      String subtitle, VoidCallback onSubmit, String btnTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Prevents unnecessary space
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Color(0x103c486b)),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/$svg",
                    color: Color(0xff3c486b),
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff3c486b),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0x903c486b),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Bekor qilish",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: onSubmit,
                    text: btnTitle,
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
