import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcodeapp/models/option.dart';
import 'package:qrcodeapp/views/scan_code_page.dart';
import 'package:qrcodeapp/widgets/option_widget.dart';
import 'package:qrcodeapp/widgets/textfield.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGenerateSelected = true;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  Option _selectedOption = Option.options[0];
  GlobalKey globalKey = GlobalKey();

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

  Future<void> _captureAndSharePng() async {
    try {
      _getShareFilePermission();
      RenderRepaintBoundary? boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List? pngBytes = byteData!.buffer.asUint8List();

      Directory? tempDir = await getTemporaryDirectory();
      File? file = await File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<PermissionStatus> _getShareFilePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      final result = await Permission.storage.request();
      return result;
    } else {
      return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            showDialog(
                context: context,
                barrierColor: Colors.black45,
                builder: (ctx) => Center(
                      child: Dialog(
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          width: 270,
                          height: 320,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: _captureAndSharePng,
                                    icon:
                                        const Icon(CupertinoIcons.share_solid),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.xmark_square_fill,
                                    ),
                                  ),
                                ],
                              ),
                              QrImage(
                                data: _textController.text.trim(),
                                version: QrVersions.auto,
                                foregroundColor: Colors.white,
                                size: 270,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
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
                  ? Column(
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
                    )
                  : const ScanQRCodePage(),
            ],
          ),
        ),
      ),
    );
  }
}
