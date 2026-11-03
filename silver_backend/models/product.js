const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
  image: {
    type: String,
    default: ""
  },
  name: String,
  price: Number,
  discount: {
    type: Number,
    default: 0
  },
  description: String,
  seller: String,
  stock: {
    type: Number,
    default: 1
  },
  orderStatus: {
    type: String,
    default: "No order"
  },
  category: String
}, {
  timestamps: true
});


module.exports = mongoose.model("product", productSchema);
