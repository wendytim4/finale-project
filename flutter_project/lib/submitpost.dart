import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js';
import 'Homepage.dart';
import 'viewprofile.dart';
import 'createprofile.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'feedpage.dart';
import 'updateprofile.dart';

class Submitpost extends StatelessWidget {
  Submitpost({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _postController = TextEditingController();

  Future<void> sendUserDataToCloudFunction() async {
    final email = _emailController.text;
    final post = _postController.text;

    const String url =
        'https://us-central1-final-project-f78c3.cloudfunctions.net/submitPost';

    Map<String, dynamic> body = {
      'email': email,
      'text': post,
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
            'What are you thinking?'), // set the title of the top navigation bar
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
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: ' Enter your correct email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please  your email  ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _postController,
                decoration:
                    const InputDecoration(labelText: ' Enter your post'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please  enter your post  ';
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
                      MaterialPageRoute(builder: (context) => Submitpost()),
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
