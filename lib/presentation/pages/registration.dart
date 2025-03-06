import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_scraper_mobile/core/services/auth_service.dart';
import 'package:geo_scraper_mobile/data/models/auth_model.dart';
import 'package:geo_scraper_mobile/presentation/pages/home.dart';
import 'package:geo_scraper_mobile/presentation/pages/login.dart';
import 'package:geo_scraper_mobile/presentation/screens/splash_screen.dart';
import 'package:geo_scraper_mobile/presentation/utils/phone_number_formatter.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String errorMessageText = "";
  bool isLoading = false;

  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  final List<TextEditingController> _registerControllers =
      List.generate(5, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _registerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  handleRegister() async {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    FirebaseAuthService auth = FirebaseAuthService();

    String? errorMessage = await auth.registration(
      _registerControllers[2].text, // Email
      _registerControllers[3].text, // Password
      _registerControllers[0].text, // Username
      _registerControllers[1].text, // Surname
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
          (Route route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    bool isValidPassword(String phoneNumber) {
      final RegExp secretCodeRegExp = RegExp(r'^[A-Za-z0-9!@#$%^&*]{6,12}$');
      return secretCodeRegExp.hasMatch(phoneNumber);
    }

    bool isValidPhoneNumber(String phoneNumber) {
      final RegExp phoneRegExp = RegExp(r'^\+998\d{9}$');
      return phoneRegExp.hasMatch(phoneNumber);
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor:
              isLoading ? Colors.black.withOpacity(0.1) : Colors.white,
          backgroundColor:
              isLoading ? Colors.black.withOpacity(0.3) : Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Stack(children: [
          SafeArea(
            child: Form(
              key: _registerKey,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  children: registerPage.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            e.logo,
                            width: screenSize.width * 0.45,
                          ),
                          Visibility(
                              visible: errorMessageText.isNotEmpty,
                              child: Container(
                                  width: double.infinity,
                                  height: 36,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      borderRadius: BorderRadius.circular(6)),
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
                          Text(
                            e.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              color: const Color(0xff3C486B).withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...e.inputs.asMap().entries.map((entry) {
                            int index = entry.key;
                            var input = entry.value;
                            return CustomTextField(
                              label: input['text'],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  switch (input["type"]) {
                                    case "phone":
                                      return "Telefon raqam kiriting";
                                    case "password":
                                      return "Iltimos, maxfiy kodni kiriting";
                                    case "confirmPassword":
                                      return "Iltimos, maxfiy kodni tasdiqlang";
                                  }
                                }

                                if (input["type"] == "phone" &&
                                    !isValidPhoneNumber(value!)) {
                                  return "Telefon raqam xato kiritilgan (masalan: +998901234567)";
                                }

                                if (input["type"] == "password" &&
                                    !isValidPassword(value!)) {
                                  return "Kod 6–12 ta belgi bo‘lishi kerak (harflar, raqamlar, !@#\$%^&*)";
                                }

                                if (input["type"] == "confirmPassword") {
                                  final passwordValue =
                                      _registerControllers[index - 1].text;
                                  if (passwordValue != value) {
                                    return "Maxfiy kod va maxfiy kodni tasdiqlash mos emas.";
                                  }
                                }

                                return null;
                              },
                              controller: _registerControllers[index],
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
                          CustomButton(
                            text: e.buttonText,
                            disabled: isLoading,
                            onPressed: () {
                              if (_registerKey.currentState!.validate() &&
                                  !isLoading) {
                                handleRegister();
                              }
                            },
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
                                  color:
                                      const Color(0xff3C486B).withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
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
        ]),
      ),
    );
  }
}
