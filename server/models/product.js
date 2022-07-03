const mongoose = require("mongoose");

// * setting array or lists of strings that will have type String and will be required for images
const productSchema = mongoose.Schema({
  name: {
    type: String,
    require: true,
    trim: true,
  },
  description: {
    type: String,
    require: true,
    trim: true,
  },
  images: [
    {
      type: String,
      require: true,
    },
  ],
  quantity: {
    type: Number,
    require: true,
  },
  price: {
    type: Number,
    require: true,
  },
  category: {
    type: String,
    require: true,
  },
});

const Product = mongoose.model("Product", productSchema);
module.exports = { Product, productSchema };
