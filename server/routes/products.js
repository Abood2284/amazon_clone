const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");

// Get products based on the category
/*
-> /api/products:category=Essentials
    to get call to this api where cat is dynamic you can req -> req.params.category  
    (category is the name we assign to the variable) // For safe side always keep it same as the model attributes & when passing on, client side also take care
    
    -> /api/products?category=Essentials
    to get call to this api where cat is dynamic you can req -> req.query.category
    (category is the name we assign to the variable)
*/
productRouter.get("/api/products", async (req, res) => {
  try {
    console.log(req.query.category);
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
});

module.exports = productRouter;
