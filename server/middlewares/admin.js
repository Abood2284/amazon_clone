const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.status(401).json({
        msg: "No auth token, access denied",
      });
    }

    const verfied = jwt.verify(token, "passwordKey");
    if (!verfied) {
      return res.status(401).json({
        msg: "Token Verification failed! Authorization denied",
      });
    }
    const user = await User.findById(verfied.id);
    if (user.type == "user" || user.type == "seller") {
      res.status(401).json({ msg: "You are not admin" });
    }
    req.user = verfied.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ msg: "error.message" });
  }
};

module.exports = admin;
