import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'createprofile.dart';
import 'viewprofile.dart';
import 'Homepage.dart';
import 'submitpost.dart';
import 'feedpage.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Edit Profile'), // set the title of the top navigation bar
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
      backgroundColor: Colors.white, // set background color of the body
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(children: [
                  Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2016/11/14/17/39/person-1824144_960_720.png')))),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.blue),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
              ),
              const SizedBox(height: 30),
              buildTextField('Special Number', 'placeholder'),
              buildTextField('Student Name', 'placeholder'),
              buildTextField('Email', 'placeholder'),
              buildTextField('Date of Birth', 'placeholder'),
              buildTextField('Year Group', 'placeholder'),
              buildTextField('Best Food', 'placeholder'),
              buildTextField('Best Movie', 'placeholder'),
              ElevatedButton(onPressed: () {}, child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(labelText, placeholder) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 5),
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,
                hintStyle: const TextStyle(fontSize: 16, color: Colors.grey))));
  }
}
