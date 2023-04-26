const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

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
