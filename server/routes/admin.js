const express = require("express");
const { Product } = require("../models/product");
const admin = require("../middlewares/admin");
const adminRouter = express.Router();

// Add a product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    let product = new Product({
      // 'let' allow us to change the variable later, 'const' doesnt
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save(); // Saving it to mongooDB
    res.json(product);
  } catch (error) {
    res.status(500).json({ msg: "error.message" });
  }
});

// Get all products
adminRouter.get("/admin/get-products", admin, async (_req, res) => {
  try {
    const products = await Product.find({}); // Not specifying any criteria means, finding all data
    res.json(products);
  } catch (error) {
    res.status(500).json({ msg: "error.message" });
  }
});

module.exports = adminRouter;
