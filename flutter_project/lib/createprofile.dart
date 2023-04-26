import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js';
import 'Homepage.dart';
import 'viewprofile.dart';
import 'submitpost.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'feedpage.dart';
import 'updateprofile.dart';

class CreateProfile extends StatelessWidget {
  CreateProfile({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _studentIDController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _yearGroupController = TextEditingController();
  final _majorController = TextEditingController();
  final _campusResidenceController = TextEditingController();
  final _bestFoodController = TextEditingController();
  final _bestMovieController = TextEditingController();

  Future<void> sendUserDataToCloudFunction() async {
    final bestFood = _bestFoodController.text;
    final bestMovie = _bestMovieController.text;
    final dob = _dateOfBirthController.text;
    final email = _emailController.text;
    final hasCampusResidence = _campusResidenceController.text;
    final major = _majorController.text;
    final name = _nameController.text;
    final studentId = _studentIDController.text;
    final yearGroup = _yearGroupController.text;

    const String url =
        'https://us-central1-final-project-f78c3.cloudfunctions.net/createProfile';

    Map<String, dynamic> body = {
      'studentId': studentId,
      'name': name,
      'dob': dob,
      'email': email,
      'yearGroup': yearGroup,
      'major': major,
      'hasCampusResidence': hasCampusResidence,
      'bestFood': bestFood,
      'bestMovie': bestMovie,
    };

    await http.post(Uri.parse(url), body: body).then((response) {
      print(response.body);
    }).catchError((error) {
      // Handle any errors that occur during the request
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Welcome to Ashesi App'), // set the title of the top navigation bar
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue, // set background color of the side bar
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    size: 24.0,
                  ),
                  onTap: () {
                    // Navigate to Create Profile Page
                  },
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Create Profile Page'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateProfile()),
                    );
                    // Navigate to Create Profile Page
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50, // <-- SEE HERE
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit Profile Page'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateProfile()),
                    );
                    // Navigate to View Profile Page
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50, // <-- SEE HERE
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.view_agenda),
                  title: const Text('View Profile Page'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileView()),
                    );
                    // Navigate to View Profile Page
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50, // <-- SEE HERE
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.create),
                  title: const Text('Create Post'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Submitpost()),
                    );
                    // Navigate to Create Post Page
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50, // <-- SEE HERE
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.feed),
                  title: const Text('Feed Page'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedPage()),
                    );
                    // Navigate to Feed Page
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,

      /// set background color of the body

      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _bestFoodController,
                decoration: const InputDecoration(labelText: 'Best Food'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter bestFood Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bestMovieController,
                decoration: const InputDecoration(labelText: 'Best Movie'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter best Movie name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Date of Birth';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _campusResidenceController,
                decoration:
                    const InputDecoration(labelText: 'Campus Residence'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return ' hasCampusResidence: Enter Yes or No';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _majorController,
                decoration: const InputDecoration(labelText: 'major'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a major';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Student Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter student Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _studentIDController,
                decoration: InputDecoration(labelText: 'Student ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter student ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearGroupController,
                decoration: InputDecoration(labelText: ' year Group '),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please  year Group  ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendUserDataToCloudFunction();
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CreateProfile()),
                    );
                  },
                  // Do something if the form is valid

                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
