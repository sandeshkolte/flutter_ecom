const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
  image: {
    type: String,
    default: "https://firebasestorage.googleapis.com/v0/b/comrade-ec6f7.appspot.com/o/watch.webp?alt=media&token=205f9253-de8c-41d2-99ce-b400cc0482e2"
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
