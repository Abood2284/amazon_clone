// THIS IS A SCHEMA A STRUCTURE OF HOW A USER SHOULD BE VALIDATED
// FIREBASE DID THIS FOR US, IT SHOULD US IF PASSWORD IS WEAK, LESS THEN 6 CHARACTER ETC
// BUT THIS HOW OUR VALIDATION LOOKS LIKE, IT SIMPLE

const mongoose = require("mongoose");

const UserSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
    // validate: {
    //   validator: (val) => {
    //     return val.length > 6;
    //   },
    // },
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user", // Only 2 values for now admin & user -> default we want everyone to be user
  },
});

// * creating a model with the above scheme
const User = mongoose.model("User", UserSchema);
module.exports = User;
