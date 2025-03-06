import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/core/services/auth_service.dart';
import 'package:geo_scraper_mobile/data/models/auth_model.dart';
import 'package:geo_scraper_mobile/presentation/pages/login.dart';
import 'package:geo_scraper_mobile/presentation/utils/phone_number_formatter.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';

class SendOtp extends StatefulWidget {
  bool? isLogged = false;
  SendOtp({super.key, this.isLogged});

  @override
  State<SendOtp> createState() => _SendOtp();
}

class _SendOtp extends State<SendOtp> {
  String errorMessageText = "";
  bool isLoading = false;

  final GlobalKey<FormState> _sendOtpForm = GlobalKey<FormState>();

  final TextEditingController phoneNumberController = TextEditingController();
  final List<TextEditingController> otpCodeControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> otpCodeFocusNodes =
      List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    phoneNumberController.dispose();
    for (var controller in otpCodeControllers) {
      controller.dispose();
    }
    for (var focusNode in otpCodeFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(otpCodeFocusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(otpCodeFocusNodes[index - 1]);
    }
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegExp = RegExp(r'^\+998\d{9}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  void sendOtp() async {
    FirebaseAuthService authService = FirebaseAuthService();
    await authService.sendOTP(phoneNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
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
          body: Stack(
            children: [
              Form(
                  key: _sendOtpForm,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      children: sendSmsPage.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            spacing: 24,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                e.logo,
                                width: MediaQuery.of(context).size.width * 0.45,
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
                                        children: [
                                          Icon(Icons.info_outline,
                                              color: Colors.red),
                                          SizedBox(width: 6),
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
                                  color:
                                      const Color(0xff3C486B).withOpacity(0.7),
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
                                      }
                                    }
                                    if (input["type"] == "phone" &&
                                        !isValidPhoneNumber(value!)) {
                                      return "Telefon raqam xato kiritilgan (masalan: +998901234567)";
                                    }

                                    return null;
                                  },
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [PhoneNumberFormatter()],
                                );
                              }),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(4, (index) {
                                    return Container(
                                      width: 65,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: CustomTextField(
                                        controller: otpCodeControllers[index],
                                        focusNode: otpCodeFocusNodes[index],
                                        keyboardType: TextInputType.number,
                                        maxLength: 1,
                                        textAlign: TextAlign.center,
                                        label: "-",
                                        onChanged: (value) =>
                                            onChanged(value, index),
                                      ),
                                    );
                                  })),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sms kod kelmadi! ",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: const Color(0xff3C486B)
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()));
                                    },
                                    child: Text(
                                      "Qayta jo'natish",
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
                              CustomButton(
                                text: e.buttonText,
                                disabled: isLoading,
                                onPressed: sendOtp,
                              ),
                              const SizedBox(height: 16),
                              Visibility(
                                visible: !widget.isLogged!,
                                child: Row(
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
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
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
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ))
            ],
          ),
        ));
  }
}
