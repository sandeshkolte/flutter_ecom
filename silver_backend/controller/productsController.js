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
  host: 'redis-11327.c295.ap-southeast-1-1.ec2.redns.redis-cloud.com',
  port: 11327,
  password: 'QipNu6LKJUmR6EEmBvGgqeKZVV2M6urw',
})



const fetchProducts = async (req,res)=>{

  let products = await redis.get("products")

  if(products){
    console.log("Get from cache")
    return res.json({
      products:JSON.parse(products)
    })
  }

 products = await productModel.find()
await redis.setex("products",30,JSON.stringify(products))

res.json({
  products
})

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

module.exports = {fetchProducts, createProduct, updateProduct, getProduct, findProduct, editProduct }
