import 'package:flutter/material.dart';

class AuthModel {
  String logo;
  String subtitle;
  String buttonText;
  String buttonType;
  String? textWithLink;
  List inputs;
  Map? textAndLinkedText;
  List? codeInputs;

  AuthModel(
      {required this.logo,
      required this.subtitle,
      required this.buttonType,
      required this.buttonText,
      this.textWithLink,
      this.textAndLinkedText,
      required this.inputs,
      this.codeInputs});
}

List<AuthModel> loginPage = [
  AuthModel(
    logo: 'assets/images/logo.png',
    subtitle: 'Iltimos Telefon raqam va Parolingizni kiriting',
    buttonType: 'filled',
    inputs: [
      {'type': 'phone', 'text': 'Telefon raqam'},
      {'type': 'password', 'text': 'Paroll kiriting'},
    ],
    textWithLink: 'Parollni unuttingizmi?',
    textAndLinkedText: {
      'text': "Akkountingiz yo'qmi?",
      'linkedText': "Ro'yxatdan o'tish"
    },
    buttonText: 'Kirish',
  ),
];
List<AuthModel> registerPage = [
  AuthModel(
    logo: 'assets/images/logo.png',
    subtitle: 'Iltimos Telefon raqam va Parolingizni kiriting',
    buttonType: 'filled',
    inputs: [
      {'type': 'name', 'text': 'Ism', 'controller': TextEditingController()},
      {
        'type': 'name',
        'text': 'Familya',
        'controller': TextEditingController()
      },
      {
        'type': 'phone',
        'text': 'Telefon raqam',
        'controller': TextEditingController()
      },
      {
        'type': 'password',
        'text': 'Paroll kiriting',
        'controller': TextEditingController()
      },
      {
        'type': 'confirmPassword',
        'text': 'Parollni tasdiqlang',
        'controller': TextEditingController()
      },
    ],
    // textWithLink: 'Parollni unuttingizmi?',
    textAndLinkedText: {'text': "Akkountingiz bormi?", 'linkedText': "Kirish"},
    buttonText: "Ro'yxatdan o'tish",
  ),
];
List<AuthModel> sendSmsPage = [
  AuthModel(
    logo: 'assets/images/logo.png',
    subtitle: "Parolingizni unutdingizmi? Ro'yxatdan o'tilgan raqamni kiriting",
    buttonType: 'filled',
    inputs: [
      {'type': 'phone', 'text': 'Telefon raqam'},
    ],
    textAndLinkedText: {'text': "Akkountingiz bormi?", 'linkedText': "Kirish"},
    buttonText: "SMS Jo'natish",
  ),
];
List<AuthModel> newPasswordPage = [
  AuthModel(
    logo: 'assets/images/logo.png',
    subtitle: "Yangi parol kiriting!",
    buttonType: 'filled',
    inputs: [
      {'type': 'password', 'text': 'Paroll kiriting'},
      {'type': 'password', 'text': 'Parollni tasdiqlang'},
    ],
    buttonText: "Tasdiqlash",
  ),
];

List<AuthModel> confirmSmsCodePage = [
  AuthModel(
    logo: 'assets/images/logo.png',
    subtitle: "Parolingizni unutdingizmi? Ro'yxatdan o'tilgan raqamni kiriting",
    buttonType: 'filled',
    inputs: [
      {
        'type': 'phone',
        'text': '+998 94 123 45 67',
        'enabled': false,
        'controller': TextEditingController(text: '+998 94 123 45 67')
      },
    ],
    codeInputs: [
      {'type': 'default', 'text': '', 'controller': TextEditingController()},
      {'type': 'default', 'text': '', 'controller': TextEditingController()},
      {'type': 'default', 'text': '', 'controller': TextEditingController()},
      {'type': 'default', 'text': '', 'controller': TextEditingController()},
    ],
    textAndLinkedText: {'text': "Akkountingiz bormi?", 'linkedText': "Kirish"},
    buttonText: "SMS Jo'natish",
  ),
];
