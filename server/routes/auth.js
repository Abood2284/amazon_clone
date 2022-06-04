const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");

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

module.exports = authRouter;
