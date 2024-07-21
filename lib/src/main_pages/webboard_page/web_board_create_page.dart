import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmai/methods/cloud_firestore/web_board.dart';
import 'package:workmai/methods/storage/upload_image.dart';
import 'package:workmai/src/decor/textfield_decor.dart';

class WebBoardCreatePage extends StatefulWidget {
  const WebBoardCreatePage({super.key});

  @override
  _WebBoardCreatePageState createState() => _WebBoardCreatePageState();
}

class _WebBoardCreatePageState extends State<WebBoardCreatePage> {
  late final ScrollController _scrollController;
  final FocusNode _focusNodeTopic = FocusNode();
  final FocusNode _focusNodeSubTopic = FocusNode();
  final FocusNode _focusNodeDesc = FocusNode();
  final WebboardService _webboardService = WebboardService();
  File? _uploadedImage;
  String? _imageUrl;
  String? _title;
  String? _content;

  @override
  void initState() {
    _scrollController = ScrollController();
    focusNode;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void focusNode() {
    _focusNodeTopic.unfocus();
    _focusNodeSubTopic.unfocus();
    _focusNodeDesc.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _body(context),
    );
  }

  AppBar _appbar(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid;
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () async {
              await _webboardService.addTopic(
                _title.toString(),
                _content.toString(),
                uid,
                _imageUrl,
              );
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.save_outlined,
              size: 32,
              color: Color(0xff327B90),
            ),
          ),
        )
      ],
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          print('unfocus');
          focusNode;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: SizedBox(
              width: double.infinity, // Ensure the column takes full width
              child: Column(
                children: [
                  _addImageBox(context),
                  const SizedBox(height: 16),
                  _topic(context),
                  const SizedBox(height: 16),
                  _desc(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addImageBox(BuildContext context) {
    final ProfileImageUploader uploader = ProfileImageUploader();
    return GestureDetector(
      onTap: () async {
        File? file = await uploader.pickImage();
        if (file != null) {
          String? imageUrl = await uploader.uploadWebBoardImage(file);
          setState(() {
            _uploadedImage = file;
            _imageUrl = imageUrl;
            print(_imageUrl);
          });
        }
      },
      child: Container(
        height: 150, // Set a fixed height
        decoration: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: _uploadedImage == null
              ? Icon(
                  Icons.add,
                  color: Color(0xff327B90),
                  size: 36,
                )
              : Image.file(
                  _uploadedImage!,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget _topic(BuildContext context) {
    return _boxDecor(
        context,
        'Topic',
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: TextFormField(
              maxLines: 2,
              decoration: textfieldDec(''),
              onChanged: (String? value) {
                _title = value;
              },
            ),
          ),
        ),
        80);
  }

  Widget _desc(BuildContext context) {
    return _boxDecor(
        context,
        'Description',
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            maxLines: 10,
            decoration: textfieldDec(''),
            onChanged: (String? value) {
              _content = value;
            },
          ),
        ),
        150);
  }

  Widget _boxDecor(
      BuildContext context, String header, Widget child, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            header,
            style: GoogleFonts.raleway(
              color: const Color(0xffA9D95A),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: height, // Set a fixed height
          decoration: BoxDecoration(
            color: const Color(0xffEFEFEF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ],
    );
  }
}
