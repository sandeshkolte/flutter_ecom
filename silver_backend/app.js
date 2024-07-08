const express = require('express');
const userRouter = require('./routes/usersRouter');
const productsRouter = require('./routes/productsRouter');
const ownersRouter = require('./routes/ownersRouter');
const appLogger = require('./middlewares/appLogger');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const db = require('./config/mongoose-config');
const productModel = require('./models/product');

const app = express();
const PORT = process.env.PORT || 9000;

// Middleware
app.use(cors());
app.set("view engine", "ejs")
require('dotenv').config();
app.use(appLogger);
app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

db.on('connected', () => {
  console.log('Mongoose connected to MongoDB Atlas');
});

db.on('error', (err) => {
  console.error('Mongoose connection error:', err);
});

db.on('disconnected', () => {
  console.log('Mongoose disconnected from MongoDB Atlas');
});

// Routes
app.get('/',async(req,res)=>{
  let products = await productModel.find();

    res.render("panel",{
        products
    })
})

app.get('/edit/:id',async (req,res)=>{

  let product = await productModel.findOne({_id:req.params.id});
  
      res.render("edit",{
          product
      })
      console.log(product)
  })

  app.post('/update/:id',async (req,res)=>{

    let {  image,
      name,
      price,
      discount,
      description,
      seller,
      stock,
      category} = req.body
    
    let updatedProduct = await productModel.findOneAndUpdate({_id:req.params.id},{  image,
      name,
      price,
      discount,
      description,
      seller,
      stock,
      category},{new:true});
       res.redirect('/')
    })
  

app.use('/users', userRouter);
app.use('/products', productsRouter);
app.use('/owner', ownersRouter);

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server started on port ${PORT}`);
});
