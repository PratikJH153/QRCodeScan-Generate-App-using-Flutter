import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcodeapp/models/option.dart';
import 'package:qrcodeapp/views/generate_code_page.dart';
import 'package:qrcodeapp/views/scan_code_page.dart';
import 'package:qrcodeapp/widgets/option_widget.dart';
import 'package:qrcodeapp/widgets/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGenerateSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            // showDialog(
            //     context: context,
            //     barrierColor: Colors.black45,
            //     builder: (ctx) => Center(
            //           child: Dialog(
            //             backgroundColor: Colors.transparent,
            //             child: SizedBox(
            //               width: 270,
            //               height: 320,
            //               child: Column(
            //                 children: [
            //                   Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       IconButton(
            //                         onPressed: () {},
            //                         icon:
            //                             const Icon(CupertinoIcons.share_solid),
            //                       ),
            //                       IconButton(
            //                         onPressed: () {
            //                           Navigator.of(context).pop();
            //                         },
            //                         icon: const Icon(
            //                           CupertinoIcons.xmark_square_fill,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   QrImage(
            //                     data: _textController.text.trim(),
            //                     version: QrVersions.auto,
            //                     foregroundColor: Colors.white,
            //                     size: 270,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ));
          },
          icon: const Icon(
            CupertinoIcons.greaterthan_square_fill,
            color: Colors.white,
          ),
          label: const Text(
            "Generate",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hey User ✋",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Let's encrypt your data!",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: OptionWidget(
                      title: "Generate Code",
                      isSelected: _isGenerateSelected,
                      onTapHandler: () {
                        setState(() {
                          _isGenerateSelected = true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: OptionWidget(
                      title: "Scan Code",
                      isSelected: !_isGenerateSelected,
                      onTapHandler: () {
                        setState(() {
                          _isGenerateSelected = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              _isGenerateSelected
                  ? const GenerateQRCodePage()
                  : const ScanQRCodePage(),
            ],
          ),
        ),
      ),
    );
  }
}
