import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';

class EditPhoneNumber extends StatefulWidget {
  const EditPhoneNumber({super.key});

  @override
  _EditPhoneNumberState createState() => _EditPhoneNumberState();
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  final TextEditingController _phoneNumberController =
      TextEditingController(text: "+998 94 124 22 02");
  final TextEditingController _newPhoneNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Telefon raqamini tahrirlash"),
        backgroundColor: Colors.white,
        // bottom: PreferredSize(
        //   preferredSize:
        //       const Size.fromHeight(1), // Set the height of the border
        //   child: Container(
        //     color: const Color(0xffd8dae1), // Border color
        //     height: 1, // Border height
        //   ),
        // ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Hozirgi telefon raqam: ",
            textAlign: TextAlign.start,
            style: TextStyle(color: Color(0xff3c486b)),
          ),
          // Constrain width of CustomTextField
          CustomTextField(
            label: "+998 94 124 22 02",
            controller: _phoneNumberController,
            readOnly: true,
            // focusNode: _focusNode,
          ),
          SizedBox(height: 24),
          const Text(
            "Yangi telefon raqam: ",
            textAlign: TextAlign.start,
            style: TextStyle(color: Color(0xff3c486b)),
          ),
          // Constrain width of CustomTextField
          CustomTextField(
            label: "Telefon raqam",
            keyboardType: TextInputType.numberWithOptions(),
            controller: _newPhoneNumberController,
            // focusNode: _focusNode,
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: CustomButton(text: "Saqlash", onPressed: () {}),
          ),
          SizedBox(height: 16),
          Center(
            child: TextButton(
                onPressed: () {},
                child: Text(
                  "Bekor qilish",
                  style: TextStyle(
                      color: Color(0xffff9556),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                )),
          )
        ]),
      )),
    );
  }
}
