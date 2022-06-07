const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.status(401).json({ msg: "No auth token, access denied" });
    }
    const isVerified = jwt.verify(token, "passwordKey");
    if (!isVerified) {
      return res
        .status(401)
        .json({ msg: "Token Verification failed! Authorization denied" });
    }
    req.user = verified.id; // WOrking as a static variable in dart
    req.token = token;
    next(); // to run the fall back function also, if you dont specify this fallback fucntion will not run
    //| Its like now run the other function written after auth middleware (where this middleware is used in auth.js)
  } catch (error) {
    res.status(500).json({ errro: error.message });
  }
};

module.exports = auth;
