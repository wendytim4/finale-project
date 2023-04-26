import 'package:flutter/material.dart';
import 'createprofile.dart';
import 'viewprofile.dart';
import 'updateprofile.dart';
import 'submitpost.dart';
import 'feedpage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                    // Navigate to View Profile Page
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // set background color of the body
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ass.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
