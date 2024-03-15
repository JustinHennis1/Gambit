import 'package:flutter/material.dart';

import 'package:gambit/components/neon_butt.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gambit/components/texttheme.dart';

String? username;
String? email;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ImagePicker _imagePicker;
  XFile? _image;
  int? userRating;

  @override
  void initState() {
    super.initState();
    //loadImage('assets/images/blur.jpg');
    getValidationData();
    _imagePicker = ImagePicker();
  }

  Future<void> loadImage(String path) async {
    try {
      // load network image example
      await precacheImage(AssetImage(path), context);
      // or
      // Load assets image example
      // await precacheImage(AssetImage(imagePath), context);
      print('Image loaded and cached successfully!');
    } catch (e) {
      print('Failed to load and cache the image: $e');
    }
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString('username');
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedrating = sharedPreferences.getInt('rating');

    setState(() {
      username = obtainedUsername;
      email = obtainedEmail;
      userRating = obtainedrating;
    });
  }

  Future<void> _getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => _buildDeleteDialog(context),
    );
  }

  Widget _buildDeleteDialog(BuildContext context) {
    return AlertDialog(
        title: const Text(
          'Delete this Account?',
          style: TextStyle(
              color: Colors.black87, wordSpacing: 2.0, letterSpacing: 2.0),
        ),
        content: DeleteAccount(username ?? "", "Delete"),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage('assets/images/blur.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.95),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Container(
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? ElevatedButton(
                    onPressed: _getImage,
                    child: const Text('Upload Profile Picture'),
                  )
                : _image != null
                    ? ClipOval(
                        child: SizedBox(
                            height: 180,
                            width: 180,
                            child: Image.file(File(_image!.path))),
                      )
                    : const SizedBox.shrink(),
            DataTable(
              columns: const [
                DataColumn(label: TextTheme4('Attribute')),
                DataColumn(label: TextTheme4('Value')),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(TextTheme4('Profile name')),
                  DataCell(TextTheme4(username ?? '')),
                ]),
                DataRow(cells: [
                  const DataCell(TextTheme4('Email')),
                  DataCell(TextTheme4(email ?? '')),
                ]),
                DataRow(cells: [
                  const DataCell(TextTheme4('Rating')),
                  DataCell(TextTheme4(userRating.toString())),
                ]),
                // Add more rows as needed for other attributes
              ],
            ),
            const SizedBox(height: 150),
            GestureDetector(
                onTap: () {
                  deleteAccount(context);
                },
                child: const Text(
                  "Delete Account",
                  style: TextStyle(
                      color: Colors.red, fontFamily: "Times New Roman"),
                )),
            //DeleteAccount(username ?? '', "Delete Account"),
          ],
        ),
      ),
    );
  }
}
