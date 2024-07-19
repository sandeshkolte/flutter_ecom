const express = require('express')
const {createProduct,updateProduct, getProduct, findProduct, editProduct} = require('../controller/productsController')
const { isOwnerLoggedIn } = require('../middlewares/isLoggedIn')
const router = express.Router()
const upload = require('../config/multer-config')

router.get('/',getProduct)
router.post('/create',upload.single('image'), createProduct)
router.get('/find/:id', findProduct); 
router.get('/find', findProduct); 
router.get('/edit/:id',/*isOwnerLoggedIn,*/editProduct)
router.post('/update/:id',upload.single('image')/*,isOwnerLoggedIn*/, updateProduct)

module.exports = router