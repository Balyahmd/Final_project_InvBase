const productRoute = require("express").Router();
const ProductController = require("../controller/productController ");

productRoute.get("/", ProductController.getProduct);
productRoute.get("/:id", ProductController.getProductById);
productRoute.post("/add", ProductController.createProduct);
productRoute.delete("/delete/:id", ProductController.delete);
productRoute.put("/update/:id", ProductController.update);

module.exports = productRoute;
