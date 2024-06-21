"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class Product extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      Product.belongsTo(models.Category, {
        foreignKey: "categoryId",
      });
      Product.belongsTo(models.User, {
        foreignKey: "createdBy",
      });
      Product.belongsTo(models.User, {
        foreignKey: "updatedBy",
      });
    }
  }
  Product.init(
    {
      name: DataTypes.STRING,
      qty: DataTypes.INTEGER,
      categoryId: DataTypes.INTEGER,
      imageUrl: DataTypes.STRING,
      createDate: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
      },
      updateDate: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
      },
      createdBy: DataTypes.INTEGER,
      updatedBy: DataTypes.INTEGER,
    },
    {
      sequelize,
      modelName: "Product",
      hooks: {
        beforeCreate: (product) => {
          const now = new Date();
          product.createDate = now;
          product.updateDate = now;
        },
        beforeUpdate: (product) => {
          product.updateDate = new Date();
        },
      },
    }
  );
  return Product;
};
