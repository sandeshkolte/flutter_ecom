
const productModel = require('../models/product')

// Routes
const home =  async(req,res)=>{
    // let products = await productModel.find();
res.send("Project working")
  }

  const createProdpage = (req,res)=>{

res.render("createproduct")

  }

  module.exports = {home,createProdpage}