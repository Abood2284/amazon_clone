//* IMPORT from packages
const express = require("express"); // optional naming: express, you can name this anything
// import 'package:express/express.dart';
const mongoose = require("mongoose");
require("dotenv").config(); // TO hide our API key more on notion

//* IMPORT from FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");

//* INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB =
  "mongodb+srv://abood:123abdul@cluster0.ie3rvas.mongodb.net/?retryWrites=true&w=majority";

//* MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

// * CONNECTIONS
mongoose
  .connect(DB)
  .then(() => {
    console.log("connection succesful");
  })
  .catch((e) => {
    console.log(e);
  });

// CREATING AN API
// GET, PUT, POST, DELETE, UPDATE -> CRUD

// https://<your-ip-address>/<your-path-name in .get>
// app.get("/", (req, res) => {
//     res.json({name: "Abdul raheem"})
// })

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`); // JS you use ` back comma and ${} for string interpolation
});
// If IP not specified then it will use default
// LOCALHOST -> for some purposes android emulator doesnt support LOCALHOST
// so for debugging purpose we are using IP 0.0.0.0 which means
// it can be accessed from anywhere
//
// 2 ways to write call back functions in JS 'function () {}'  OR '() => {}'
