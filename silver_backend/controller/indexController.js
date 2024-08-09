
const productModel = require('../models/product')

// Routes
const home =  async(req,res)=>{
    let products = await productModel.find();
  
    res.status(200).json({
      response:products
    })
      res.render("panel",{
          products
      })
  }

  const createProdpage = (req,res)=>{

res.render("createproduct")

  }

  module.exports = {home,createProdpage}