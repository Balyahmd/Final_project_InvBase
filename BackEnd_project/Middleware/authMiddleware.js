const jwt = require("jsonwebtoken");

const verifyToken = (req, res, next) => {
  const token = req.header("Authorization").split(" ")[1];
  if (!token) return res.status(401).json({ error: "Access denied" });

  try {
    const verified = jwt.verify(token, "h2123j1kj141lk24k4h");
    req.user = verified;
    next();
  } catch (error) {
    res.status(400).json({ error: "Invalid token" });
  }
};

module.exports = { verifyToken };
