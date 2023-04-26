const admin = require("firebase-admin");
const functions = require("firebase-functions");
admin.initializeApp();
const express = require("express");
const app=express();
const cors = require("cors");
const bodyParser = require("body-parser");
app.use(cors({
  origin: ["https://www.section.io", "htps://wwww.google.com/"],
}));

app.use(cors({
  origin: "*",
}));

exports.createProfile = functions.https.onRequest(async (req, res) => {
  // Get the user profile data from the request body
  const data = req.body;

  try {
    // Create a new user profile document in Firestore
    const result = await admin.firestore().collection("profiles").add({
      studentId: data.studentId,
      name: data.name,
      email: data.email,
      dob: data.dob,
      yearGroup: data.yearGroup,
      major: data.major,
      hasCampusResidence: data.hasCampusResidence,
      bestFood: data.bestFood,
      bestMovie: data.bestMovie,
    });

    // Send a success response back to the Flutter app
    res.status(200).json({
      success: true,
      message: "User profile created successfully",
      data: {
        id: result.id,
      },
    });
  } catch (error) {
    // Send an error response back to the Flutter app
    console.error(error);
    res.status(500).json({
      success: false,
      message: "Failed to create user profile",
      error: error.message,
    });
  }
});

// Set the function to be callable by all users
exports.createProfile.options = {
  cors: {
    origin: "*",
  },
};

exports.getProfile = functions.https.onRequest(async (req, res) => {
  // Get the student ID from the request query parameter
  const studentId = req.query.studentId;

  try {
    // Retrieve the user profile document from Firestore based on the student ID
    const profileRef = await admin.firestore().collection("profiles").where(
        "studentId", "==",
        studentId).get();
    if (profileRef.empty) {
      // If no user profile is found with the given student ID,
      // send a 404 error response back to the client
      res.status(404).json({
        success: false,
        message: "User profile not found",
      });
    } else {
      // If a user profile is found with the given student ID,
      // extract the data and send a success response back to the client
      const profileData = profileRef.docs[0].data();
      res.status(200).json({
        success: true,
        message: "User profile retrieved successfully",
        data: profileData,
      });
    }
  } catch (error) {
    // Send an error response back to the client if an error occurs
    console.error(error);
    res.status(500).json({
      success: false,
      message: "Failed to retrieve user profile",
      error: error.message,
    });
  }
});
exports.getProfile.options = {
  cors: {
    origin: "*",
  },
};

exports.updateProfile = functions.https.onRequest(async (req, res) => {
  const data = req.body;
  try {
    // Check if the user exists in the database
    const snapshot = await admin.firestore().collection("profiles").where(
        "studentId", "==",
        data.studentId).get();
    if (snapshot.empty) {
      res.status(404).json({
        success: false,
        message: "User profile not found",
      });
    } else {
      // Get the user profile document ID
      const docId = snapshot.docs[0].id;

      // Update the user profile document in Firestore
      await admin.firestore().collection("profiles").doc(docId).update({
        dob: data.dob,
        yearGroup: data.yearGroup,
        major: data.major,
        hasCampusResidence: data.hasCampusResidence,
        bestFood: data.bestFood,
        bestMovie: data.bestMovie,
      });

      // Send a success response back to the Flutter app
      res.status(200).json({
        success: true,
        message: "User profile updated successfully",
      });
    }
  } catch (error) {
    // Send an error response back to the Flutter app
    console.error(error);
    res.status(500).json({
      success: false,
      message: "Failed to update user profile",
      error: error.message,
    });
  }
});
exports.updateProfile.options = {
  cors: {
    origin: "*",
  },
};

app.use(cors({origin: true}));
app.use(bodyParser.json());

exports.submitPost = functions.https.onRequest(async (req, res) => {
  try {
    const {email, text} = req.body;
    const now = new Date();
    let timestamp = now.getFullYear()+"/"+(now.getMonth()+1)+"/"+
    now.getDate();
    timestamp += " "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();

    const post = {
      email,
      text,
      timestamp,
    };
    // Add the post to the Firestore collection "posts"
    await admin.firestore().collection("posts").add(post);
    res.status(201).json({
      success: true,
      message: "Post created successfully",
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      success: false,
      message: "Failed to create post",
      error: error.message,
    });
  }
});

exports.submitPost.options = {
  cors: {
    origin: "*",
  },
};

// Route to get all posts in descending order of time
exports.getPost = functions.https.onRequest(async (req, res) => {
  try {
    // Get all posts in descending order of timestamp
    const postsSnapshot = await admin.firestore().collection(
        "posts").orderBy("timestamp", "desc").get();
    const posts = postsSnapshot.docs.map(
        (doc) => ({id: doc.id, ...doc.data()}));
    res.status(200).json({success: true, posts});
  } catch (error) {
    console.error(error);
    res.status(500).json(
        {success: false, message: "Failed to get posts", error: error.message});
  }
});
exports.getPost.options = {
  cors: {
    origin: "*",
  },
};

exports.updateStudentInfo = async (data, context) => {
  // Ensure the user is authenticated
  if (!context.auth) {
    throw new Error("Authentication required.");
  }

  const {studentId, dateOfBirth, yearGroup, major,
    hasCampusResidence, bestFood, bestMovie} = data;

  try {
    const studentRef = admin.firestore().collection(
        "students").doc(studentId);

    // Update the student's information in Firebase
    await studentRef.update({
      dateOfBirth,
      yearGroup,
      major,
      hasCampusResidence,
      bestFood,
      bestMovie,
    });

    console.log("Student with ID ${studentId} has been updated.");

    // Return a success message
    return {message: "Student with ID ${studentId} has been updated."};
  } catch (error) {
    console.error(error);
    throw new Error("Error updating student with ID ${studentId}.");
  }
};
