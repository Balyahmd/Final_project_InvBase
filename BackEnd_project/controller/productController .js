const { Product, Category, User } = require("../models");

class ProductController {
  static async getProduct(req, res) {
    try {
      let products = await Product.findAll({
        include: [Category, User],
      });
      res.json(products);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  static async getProductById(req, res) {
    try {
      const id = +req.params.id;
      let product = await Product.findByPk(id, {
        include: [Category, User],
      });
      if (!product) {
        return res.status(404).json({ message: "Product not found" });
      }
      res.json(product);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  static async createProduct(req, res) {
    try {
      const { name, qty, categoryId, imageUrl, createdBy, updatedBy } =
        req.body;
      const userId = req.user.id;
      const product = await Product.create({
        name,
        qty,
        categoryId,
        imageUrl,
        createdBy: userId,
        updatedBy: userId,
      });
      res.status(201).json(product);
    } catch (error) {
      res.status(400).json({ error: err.message });
    }
  }

  static async update(req, res) {
    const id = +req.params.id;
    const { name, qty, categoryId, imageUrl, updatedBy } = req.body;
    const userId = req.user.id;
    try {
      await Product.update(
        {
          name,
          qty,
          categoryId,
          imageUrl,
          updatedBy: userId,
        },
        {
          where: { id },
        }
      );
      res.json({ message: "Update success" });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  static async delete(req, res) {
    try {
      const product = await Product.findByPk(+req.params.id);
      if (!product) {
        return res.status(404).json({ message: "Product not found" });
      }
      await product.destroy();
      res.json({ message: "Product deleted" });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }
}

module.exports = ProductController;
