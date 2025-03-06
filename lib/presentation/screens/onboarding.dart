import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/data/models/onboarding_model.dart';
import 'package:geo_scraper_mobile/presentation/pages/login.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: const Color(0xffffffff),
        body: Column(children: [
          Container(
            alignment: Alignment.centerRight,
            child: scipButton(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(onboardingModelContents.length,
                (index) => buildDot(index, context)),
          ),
          Expanded(
            child: Stack(alignment: Alignment.bottomCenter, children: [
              PageView.builder(
                  controller: _controller,
                  itemCount: onboardingModelContents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            onboardingModelContents[i].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: "Josefin Sans",
                              color: Color(0xffd85e16),
                              fontWeight: FontWeight.w900,
                              fontSize: 36,
                            ),
                          ),
                        ),
                        Image(
                          image: AssetImage(
                              onboardingModelContents[i].imageSource),
                        ),
                        // Button()
                      ],
                    );
                  }),
              onBoardingButton(),
            ]),
          )
        ]));
  }

  void scipToRegisterPage() async {
    await StorageService.markOnboardingAsSeen();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
        ModalRoute.withName('registration/'));
  }

  TextButton scipButton(BuildContext context) {
    return TextButton(
        onPressed: scipToRegisterPage,
        child: Text("o'tkazib yuborish".toUpperCase(),
            style: const TextStyle(
                fontFamily: "Josefin Sans", color: Color(0xff3C486B))));
  }

  Container onBoardingButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      width: double.infinity,
      child: CustomButton(
        type: CustomButtonType.white,
        text: currentIndex == onboardingModelContents.length - 1
            ? "Dovom ettirish"
            : "Keyingi",
        onPressed: () {
          if (currentIndex == onboardingModelContents.length - 1)
            scipToRegisterPage();
          _controller.nextPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceIn);
        },
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: currentIndex == index ? 25 : 10,
      height: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffd85e16)),
    );
  }
}
