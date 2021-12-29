import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController textEditingController;

  const TextFieldWidget({
    required this.title,
    required this.icon,
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: Colors.white,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFdedede),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF292929),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              autofocus: false,
              controller: textEditingController,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter a valid input";
                }
                return null;
              },
              cursorColor: const Color(0xFFf2f4f9),
              keyboardType: title == "Text" || title == "Message"
                  ? TextInputType.multiline
                  : title == "Phone Number"
                      ? const TextInputType.numberWithOptions()
                      : title == "Latitude" || title == "Longitude"
                          ? TextInputType.number
                          : title == "URL"
                              ? TextInputType.url
                              : TextInputType.text,
              maxLines: title == "Text" || title == "Message" ? 3 : 1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
