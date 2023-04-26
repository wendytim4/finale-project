import 'package:flutter/material.dart';
import 'createprofile.dart';
import 'updateprofile.dart';
import 'submitpost.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'feedpage.dart';

class UserProfileView extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UserProfileView> {
  TextEditingController _controller = TextEditingController();
  String _studentId = "";
  Map<String, dynamic> _data = {};

  Future<void> _getProfile() async {
    final response = await http.post(
        Uri.parse(
            'https://us-central1-final-project-f78c3.cloudfunctions.net/getProfile?studentId=$_studentId'),
        body: json.encode({"studentId": _studentId}));
    final responseData = json.decode(response.body);
    setState(() {
      _data = responseData['data'];
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enter student ID",
              ),
              onChanged: (value) {
                setState(() {
                  _studentId = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getProfile,
              child: const Text("Get Profile"),
            ),
            const SizedBox(height: 16),
            _data.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Name: ${_data['name']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Email: ${_data['email']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Student ID: ${_data['studentId']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Year Group: ${_data['yearGroup']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Major: ${_data['major']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Date of Birth: ${_data['dob']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Favorite Food: ${_data['bestFood']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Favorite Movie: ${_data['bestMovie']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Has Campus Residence: ${_data['hasCampusResidence']}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
