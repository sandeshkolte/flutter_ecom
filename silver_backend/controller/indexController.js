
const productModel = require('../models/product')

// Routes
const home =  async(req,res)=>{
    let products = await productModel.find();
  
      res.render("panel",{
          products
      })
  }

  const createProdpage = (req,res)=>{

res.render("createproduct")

  }

  module.exports = {home,createProdpage}