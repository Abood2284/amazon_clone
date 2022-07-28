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

// ! Get product based on the name -> We are doing this dfferently than the above one
// -> /api/products/search/i
// -> req.params.name , coz in api we have named it as name
// * We are using regex(supported by MongooDB) to search for the name, so we can search for any string using thier first letter
// * Alternate approach would be that you could search for the name using the whole name(But every letter must be corre)
productRouter.get("/api/products/search/:name", async(req, res) => {
  try {
    const products = await Product.find({name : {$regex : req.params.name, $options : 'i'}});
    res.json(products);
  }catch(error){
    res.status(500).json({ msg: error.message });
  }
});

module.exports = productRouter;
