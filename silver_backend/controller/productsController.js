const productModel = require('../models/product');
const mongoose = require('mongoose');
const saltedMd5 = require("salted-md5");
const path = require('path');
const express = require('express');
const app = express();
const multer = require('multer');
// const redis = require('../app');
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

const Redis = require('ioredis');

const redis = new Redis({
  host: process.env.REDISHOST,
  port: 11327,
  password: process.env.REDISPASS,
})

const fetchProducts = async (req, res) => {

  let products = await redis.get("products")

  if (products) {
    console.log("Get from cache")
    return res.json({
      products: JSON.parse(products)
    })
  }

  products = await productModel.find()
  await redis.setex("products", 30, JSON.stringify(products))

  res.status(200).json({ status: "success", response: products })

}

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
    const { category } = req.query;
    const product = await productModel.find({ category: { $regex: category, $options: "i" } });
    res.status(200).json({ status: "success", response: product });
  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};


const createProduct = async (req, res) => {
  try {
    let {
      name,
      image,
      price,
      discount,
      description,
      seller,
      stock,
      category,
    } = req.body;

    console.log("Request Body:", req.body);

    let product = new productModel({
      name,
      image,
      price,
      discount,
      description,
      seller,
      stock,
      category
    });

    await product.save();
    res.status(201).json({
      status: "success",
      response: "Product Created Successfully"
    })

  }


  catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
}

const editProduct = async (req, res) => {
  try {
    let product = await productModel.findById(req.params.id);

    res.status(200).json({
      product
    })
  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

const deleteProduct = async (req, res) => {
  try {
    console.log(req.query.id);
    let product = await productModel.findOneAndDelete({ _id: req.query.id });
    res.status(200).json({
      status: "success",
      response: `Item deleted`
    })
  } catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

const updateProduct = async (req, res) => {
  try {

    let { image, name, price, discount, description, seller, stock, category } = req.body;

    let updatedProduct = await productModel.findOneAndUpdate(
      { _id: req.params.id },
      {
        image,
        name, price, discount, description, seller, stock, category
      },
      { new: true }
    );

    res.status(200).json({
      status: "success",
      response: "Product Updated"
    })

  }

  // stream.end(req.file.buffer);
  catch (err) {
    res.status(400).json({ status: "Error", response: err.message });
  }
};

// Middleware to handle file uploads in createProduct
// app.post('/create-product', upload.single('file'), createProduct); 

module.exports = { fetchProducts, createProduct, updateProduct, getProduct, findProduct, editProduct, deleteProduct }
