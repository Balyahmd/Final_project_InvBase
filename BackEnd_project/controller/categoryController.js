const { Category } = require("../models");

class CategoryController {
  static async getCategory(req, res) {
    try {
      let categories = await Category.findAll();
      res.json(categories);
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
  }

  static async getAllCategory(req, res) {
    try {
      const id = +req.params.id;
      let category = await Category.findByPk(id);
      if (!category) {
        return res.status(404).json({ message: "Product not found" });
      }
      res.json(category);
    } catch (error) {
      res.status(400).json({ error: error, message });
    }
  }

  static async create(req, res) {
    try {
      const { name } = req.body;
      const category = await Category.create({ name });
      res.status(201).json(category);
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
  }

  static async update(req, res) {
    try {
      const id = +req.params.id;
      const { name } = req.body;
      await Category.update({ name }, { where: { id } });
      res.json({ message: "Update success" });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  static async delete(req, res) {
    try {
      const category = await Category.findByPk(+req.params.id);
      if (!category) {
        return res.status(404).json({ message: "Category not found" });
      }
      await category.destroy();
      res.json({ message: "Category deleted" });
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }
}

module.exports = CategoryController;
