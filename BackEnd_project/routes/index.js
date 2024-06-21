const route = require("express").Router();
const { initializeUpload } = require("../Middleware/UploadMiddleware");
const UploadController = require("../controller/uploadController");
const { verifyToken } = require("../Middleware/authMiddleware");

route.get("/", (req, res) => {
  res.json("Welcome To My API Invbase");
});

const authRoute = require("./auth");
route.use("/auth", authRoute);

const categoryRoute = require("./category");
route.use("/category", verifyToken, categoryRoute);

const productRoute = require("./product");
route.use("/product", verifyToken, productRoute);

const uploadImage = initializeUpload();
route.post(
  "/upload",
  verifyToken,
  uploadImage.single("image"),
  UploadController.uploadImage
);

module.exports = route;
