const authRoute = require("express").Router();
const AuthController = require("../controller/authController");

authRoute.post("/register", AuthController.register);
authRoute.post("/login", AuthController.login);

module.exports = authRoute;
