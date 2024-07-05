const productModel = require('../models/product');

const getProduct = async (req, res) => {
  try {
    let products = await productModel.find();
    res.status(200).json({status:"success",response: products});
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
    const {
      image,
      name,
      price,
      discount,
      description,
      seller,
      stock,
      category,
    } = req.body;

    let product = await productModel.findOne({ _id: req.params.id });

    if (!product) return res.status(404).json({ status: "Error", response: "Product not found" });

    let updatedProduct = await productModel.findOneAndUpdate({ _id: req.params.id },
      {
        image,
        name,
        price,
        discount,
        description,
        seller,
        stock,
        category
      },
      { new: true } // To return the updated document
    );

    res.status(200).json({ status: "success", response: updatedProduct });

  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

module.exports = { createProduct, updateProduct, getProduct };
