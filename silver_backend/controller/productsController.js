const productModel = require('../models/product');
const mongoose = require('mongoose'); 

const getProduct = async (req, res) => {
  try {
    let products = await productModel.find();
    res.status(200).json({status:"success",response: products});
  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};


const findProduct = async (req, res) => {
  try {
    const id = req.params.id || req.query.id; // Support both route and query parameters
    console.log(`Finding product with ID: ${id}`);

    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ status: "Error", response: "Invalid product ID" });
    }

    const product = await productModel.findById(id);
    if (!product) {
      return res.status(404).json({ status: "Error", response: "Product not found" });
    }

    res.status(200).json({ status: "success", response: product });
  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

const createProduct = async (req, res) => {
  try {
    let {
      image,
      name,
      price,
      discount,
      description,
      seller,
      stock,
      category,
    } = req.body;

    // Log the request body to verify
    console.log("Request Body:", req.body);

    let product = new productModel({
      image,
      name,
      price,
      discount,
      description,
      seller,
      stock,
      category
    });

    // Save product
    await product.save();
    res.status(201).json({ status: "success", response: product });

  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

const updateProduct = async (req, res) => {
  try {
    const updates = req.body;
    console.log(`Updating product with ID: ${req.params.id}`);
    
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
      return res.status(400).json({ status: "Error", response: "Invalid product ID" });
    }

    const updatedProduct = await productModel.findByIdAndUpdate(
      req.params.id,
      { $set: updates },
      { new: true }
    );

    if (!updatedProduct) {
      return res.status(404).json({ status: "Error", response: "Product not found" });
    }

    res.status(200).json({ status: "success", response: updatedProduct });

  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};


module.exports = { createProduct, updateProduct, getProduct,findProduct };
