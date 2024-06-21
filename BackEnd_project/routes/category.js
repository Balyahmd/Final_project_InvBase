const categoryRoute = require("express").Router();
const CategoryController = require("../controller/categoryController");

categoryRoute.get("/", CategoryController.getCategory);
categoryRoute.get("/:id", CategoryController.getAllCategory);
categoryRoute.post("/add", CategoryController.create);
categoryRoute.put("/update/:id", CategoryController.update);
categoryRoute.delete("/delete/:id", CategoryController.delete);

module.exports = categoryRoute;
