import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcodeapp/models/option.dart';
import 'package:qrcodeapp/widgets/textfield.dart';

class GenerateQRCodePage extends StatefulWidget {
  const GenerateQRCodePage({Key? key}) : super(key: key);

  @override
  _GenerateQRCodePageState createState() => _GenerateQRCodePageState();
}

class _GenerateQRCodePageState extends State<GenerateQRCodePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  Option _selectedOption = Option.options[0];

  @override
  void dispose() {
    disposingTextController();
    super.dispose();
  }

  void disposingTextController() {
    _textController.dispose();
    _urlController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _subjectController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            runSpacing: 20,
            spacing: 20,
            children: Option.options
                .map(
                  (option) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOption = option;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedOption == option
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          width: 3,
                          color: _selectedOption == option
                              ? const Color(0xFF26a66c)
                              : const Color(0xFF2e2e2e),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(option.icon,
                              size: 20,
                              color: _selectedOption == option
                                  ? Colors.white
                                  : Colors.grey),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            option.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedOption == option
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (_selectedOption.title == "Text")
          TextFieldWidget(
            title: "Text",
            icon: CupertinoIcons.textformat_alt,
            textEditingController: _textController,
          ),
        if (_selectedOption.title == "URL")
          TextFieldWidget(
            title: "URL",
            icon: CupertinoIcons.link,
            textEditingController: _urlController,
          ),
        if (_selectedOption.title == "Phone")
          TextFieldWidget(
            title: "Phone Number",
            icon: CupertinoIcons.phone,
            textEditingController: _phoneController,
          ),
        if (_selectedOption.title == "Email")
          Column(
            children: [
              TextFieldWidget(
                title: "Email Address",
                icon: CupertinoIcons.mail,
                textEditingController: _emailController,
              ),
              TextFieldWidget(
                title: "Subject",
                icon: CupertinoIcons.textformat,
                textEditingController: _subjectController,
              ),
              TextFieldWidget(
                title: "Message",
                icon: CupertinoIcons.t_bubble,
                textEditingController: _messageController,
              ),
            ],
          ),
        if (_selectedOption.title == "Location")
          Column(
            children: [
              TextFieldWidget(
                title: "Latitude",
                icon: CupertinoIcons.location,
                textEditingController: _latitudeController,
              ),
              TextFieldWidget(
                title: "Longitude",
                icon: CupertinoIcons.location,
                textEditingController: _longitudeController,
              ),
            ],
          ),
      ],
    );
  }
}
