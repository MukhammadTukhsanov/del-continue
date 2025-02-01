import 'package:flutter/material.dart';

class TextFieldSmsCode extends StatefulWidget {
  const TextFieldSmsCode({Key? key}) : super(key: key);

  @override
  _TextFieldSmsCodeState createState() => _TextFieldSmsCodeState();
}

class _TextFieldSmsCodeState extends State<TextFieldSmsCode> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  bool _isSubmitEnabled = false;
  bool _isLastFieldDisabled = false;

  void _onChanged(
      String value, FocusNode currentFocusNode, FocusNode nextFocusNode) {
    if (value.isNotEmpty) {
      currentFocusNode.unfocus();
      FocusScope.of(context).requestFocus(nextFocusNode);
    }

    setState(() {
      _isSubmitEnabled = _controller1.text.isNotEmpty &&
          _controller2.text.isNotEmpty &&
          _controller3.text.isNotEmpty &&
          _controller4.text.isNotEmpty;
    });
    // Close the keyboard after entering the last number
    if (_isLastFieldDisabled) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(_controller1, _focusNode1, _focusNode2),
            SizedBox(width: 10),
            _buildTextField(_controller2, _focusNode2, _focusNode3),
            SizedBox(width: 10),
            _buildTextField(_controller3, _focusNode3, _focusNode4),
            SizedBox(width: 10),
            _buildTextField(_controller4, _focusNode4,
                _focusNode4), // No next focus after this
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isSubmitEnabled ? _onSubmit : null,
          child: Text('Submit'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, FocusNode focusNode,
      FocusNode nextFocusNode) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: "",
          fillColor: Color(0xfff5f6f8),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffe7e9ee)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffe7e9ee), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        onChanged: (value) => _onChanged(value, focusNode, nextFocusNode),
      ),
    );
  }

  void _onSubmit() {
    String code = _controller1.text +
        _controller2.text +
        _controller3.text +
        _controller4.text;
    print('Submitted SMS Code: $code');
  }
}
