const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken"); // For signing the user
const auth = require("../middlewares/auth");

const authRouter = express.Router();

// *  ✅✅✅ SIGNUP ✅✅✅
authRouter.post("/api/signup", async (req, res) => {
  // * 1. fetch the data from the client side
  // * 2. post the data in the database
  try {
    // * 1. 📌
    const { name, email, password } = req.body;

    // * 2. 📌
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with the entered email already exists" });
    }

    //! TO Encrypt the pass
    const hashedPassword = await bcryptjs.hash(password, 8);

    // Creating User model's object
    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// *  ✅✅✅ SIGNIN ✅✅✅
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: "User not found with that email" });
    }
    // It compares normal string with the hashed one -> returns boolean promise
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// API TO CHECK IF THE TOKEN IS VALID OR NOT
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    // Checking if there is a token
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);

    // check if the token is valid
    const isVerified = jwt.verify(token, "passwordKey");
    if (!isVerified) return res.json(false);

    // check if user exists after all
    const user = await User.findById(isVerified.id); // Becuase id was passed as a payload to token
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get USer Data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user); // req.user is only available because of auth middleware
  res.json({ ...user._doc, token: req.token });
}); // auth -> is the middleware, responsible to make sure you have the capability to auth | it works like you are extracting the logic outside this file, now whenever you want to acces user token or user just use req.user while passing auth middleware
// next(): -> becuase of next this fallback function will execute

// So now this file is ready to be used from index.js
module.exports = authRouter;
