import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/auth_service.dart';
import 'package:geo_scraper_mobile/data/models/auth_model.dart';
import 'package:geo_scraper_mobile/presentation/pages/registration.dart';
import 'package:geo_scraper_mobile/presentation/pages/send_otp.dart';
import 'package:geo_scraper_mobile/presentation/screens/splash_screen.dart';
import 'package:geo_scraper_mobile/presentation/utils/phone_number_formatter.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String errorMessageText = "";
  bool isLoading = false;

  bool market = false;
  bool delivery = false;
  bool client = true;

  DateTime? lastPressed;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final List<TextEditingController> _loginPageControllers =
      List.generate(2, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _loginPageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegExp = RegExp(r'^\+998\d{9}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  bool isValidPassword(String phoneNumber) {
    final RegExp secretCodeRegExp = RegExp(r'^[A-Za-z0-9!@#$%^&*]{6,12}$');
    return secretCodeRegExp.hasMatch(phoneNumber);
  }

  handleLogin() async {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    FirebaseAuthService auth = FirebaseAuthService();

    String? errorMessage = await auth.login(
      _loginPageControllers[0].text, // Email/Phone
      _loginPageControllers[1].text, // Password
    );

    setState(() {
      isLoading = false;
    });

    if (errorMessage != null) {
      setState(() {
        errorMessageText = errorMessage;
      });
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => SplashScreen()),
        (Route route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        DateTime now = DateTime.now();
        if (lastPressed == null ||
            now.difference(lastPressed!) > Duration(seconds: 2)) {
          lastPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Qayta bosish orqali aplikatsiya yopiladi.")),
          );
        } else {
          exit(0);
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              SafeArea(
                child: Form(
                  key: _loginKey,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      children: loginPage.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 18,
                            children: [
                              Image.asset(
                                market
                                    ? "assets/images/logo-market.png"
                                    : delivery
                                        ? "assets/images/logo-delivery.png"
                                        : e.logo,
                                width: screenSize.width * 0.45,
                              ),
                              Text(
                                e.subtitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  color:
                                      const Color(0xff3C486B).withOpacity(0.7),
                                ),
                              ),
                              Visibility(
                                  visible: errorMessageText.isNotEmpty,
                                  child: Container(
                                      width: double.infinity,
                                      height: 36,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.red[50],
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Row(
                                        spacing: 6,
                                        children: [
                                          Icon(Icons.info_outline,
                                              color: Colors.red),
                                          Expanded(
                                              child: Text(
                                            errorMessageText,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.red),
                                          ))
                                        ],
                                      ))),
                              ...e.inputs.asMap().entries.map((entry) {
                                int index = entry.key;
                                var input = entry.value;
                                return CustomTextField(
                                  label: input['text'],
                                  validator: (value) {
                                    if ((value == null || value.isEmpty) &&
                                        input["type"] == "phone") {
                                      return "Telefon raqam kiriting";
                                    } else if ((value == null ||
                                            value.isEmpty) &&
                                        input["type"] == "password") {
                                      return "Iltimos, maxfiy kodni kiriting";
                                    }
                                    if (!isValidPhoneNumber(value!) &&
                                        input["type"] == "phone") {
                                      return "Telefon raqam xato kiritilgan (masalan: +998901234567)";
                                    }
                                    if (!isValidPassword(value) &&
                                        input["type"] == "password") {
                                      return "Kod 6–12 ta belgi bo‘lishi kerak (harflar, raqamlar, !@#\$%^&*)";
                                    }
                                    return null;
                                  },
                                  controller: _loginPageControllers[index],
                                  keyboardType: input['type'] == "phone"
                                      ? TextInputType.phone
                                      : TextInputType.text,
                                  inputFormatters: input['type'] == "phone"
                                      ? [PhoneNumberFormatter()]
                                      : [
                                          LengthLimitingTextInputFormatter(12),
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[A-Za-z0-9!@#$%^&*]')),
                                        ],
                                );
                              }),
                              if (e.textWithLink != null)
                                Transform.translate(
                                  offset:
                                      Offset(screenSize.width / 2 - 125, -18),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SendOtp()));
                                    },
                                    child: Text(
                                      e.textWithLink!,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: const Color(0xff3C486B)
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  // type: e.buttonType,
                                  text: e.buttonText,
                                  onPressed: handleLogin,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    e.textAndLinkedText!['text'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: const Color(0xff3C486B)
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Registration()));
                                    },
                                    child: Text(
                                      e.textAndLinkedText!['linkedText'],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: const Color(0xffff9556)
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3), // Dim background
                  child: Center(
                    child: LoadingAnimationWidget.halfTriangleDot(
                        color: Color(0xff3c486b), size: 50),
                  ),
                ),
            ])),
      ),
    );
  }
}
