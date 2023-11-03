import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gambit/pages/texttheme.dart';

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

    Future.delayed(const Duration(microseconds: 500), () async {
      await getValidationData();
    });

    Future.delayed(const Duration(microseconds: 500), () async {
      await fetchUserRating(username, email);
    });

    _imagePicker = ImagePicker();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString('username');
    var obtainedEmail = sharedPreferences.getString('email');

    setState(() {
      username = obtainedUsername;
      email = obtainedEmail;
    });
  }

  Future<void> fetchUserRating(username, email) async {
    final dio = Dio();
    const baseUrl = 'http://10.0.2.2:5000';

    if (username != null) {
      print('Username: $username');
      print('Email = $email');
    } else {
      print('Username is null');
    }

    try {
      final response = await dio.get('$baseUrl/get_rating/$username');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map && responseData.containsKey('rating')) {
          final rating = responseData['rating'];
          setState(() {
            userRating = rating.toInt();
          });
          print(rating);
        } else {
          print('Unexpected response format: $responseData');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Dio error: $e');
      if (e is DioException) {
        print('Dio response: ${e.response?.data}');
      }
    }
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
                    ? SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(File(_image!.path)))
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
                  DataCell(TextTheme4(userRating?.toString() ?? '')),
                ]),
                // Add more rows as needed for other attributes
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
