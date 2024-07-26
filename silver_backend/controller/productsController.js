const productModel = require('../models/product');
const mongoose = require('mongoose');
const saltedMd5 = require("salted-md5");
const path = require('path');
const express = require('express');
const app = express();
const multer = require('multer');
// const admin = require("firebase-admin");
// const serviceAccount = require("../serviceAccountKey.json");
require('dotenv').config();

// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
//   storageBucket: process.env.BUCKET_URL
// });

// app.locals.bucket = admin.storage().bucket();

// Set up multer for handling file uploads
const storage = multer.memoryStorage();
const upload = multer({ storage });

const getProduct = async (req, res) => {
  try {
    let products = await productModel.find();
    res.status(200).json({ status: "success", response: products });
  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

const findProduct = async (req, res) => {
  try {
    const id = req.params.id || req.query.id;
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
    // const imgname = saltedMd5(req.file.originalname, 'SUPER-S@LT!');
    // const fileName = imgname + path.extname(req.file.originalname);

    // const file = app.locals.bucket.file(fileName);
    // const stream = file.createWriteStream();

    // stream.on('error', (err) => {
    //   throw new Error(`Failed to upload image to Firebase Storage: ${err.message}`);
    // });

    // stream.on('finish', async () => {
      let {
        name,image,
        price,
        discount,
        description,
        seller,
        stock,
        category,
      } = req.body;

      console.log("Request Body:", req.body);

      let product = new productModel({
        // image: fileName, // Save only the file name or URL if available
        name,image,
        price,
        discount,
        description,
        seller,
        stock,
        category
      });

      await product.save();
      res.redirect('/');
    }

    // stream.end(req.file.buffer);

   catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
}

const editProduct = async (req, res) => {
  try {
    let product = await productModel.findOne({ _id: req.params.id });

    res.render("edit", {
      product
    });
  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

const updateProduct = async (req, res) => {
  try {
    // const imgname = saltedMd5(req.file.originalname, 'SUPER-S@LT!');
    // const fileName = imgname + path.extname(req.file.originalname);

    // const file = app.locals.bucket.file(fileName);
    // const stream = file.createWriteStream();

    // stream.on('error', (err) => {
    //   throw new Error(`Failed to upload image to Firebase Storage: ${err.message}`);
    // });

    // stream.on('finish', async () => {

    let { name, price, discount, description, seller, stock, category } = req.body;

    let updatedProduct = await productModel.findOneAndUpdate(
      { _id: req.params.id },
      { 
        // image : fileName,
         name, price, discount, description, seller, stock, category },
      { new: true }
    );

    res.redirect('/');
  }

  // stream.end(req.file.buffer);
   catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

// Middleware to handle file uploads in createProduct
// app.post('/create-product', upload.single('file'), createProduct);

module.exports = { createProduct, updateProduct, getProduct, findProduct, editProduct }
