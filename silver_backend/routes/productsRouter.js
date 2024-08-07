const express = require('express')
const {createProduct,updateProduct, getProduct, findProduct, editProduct, fetchProducts} = require('../controller/productsController')
const { isOwnerLoggedIn } = require('../middlewares/isLoggedIn')
const router = express.Router()
const upload = require('../config/multer-config')

router.get('/',getProduct)
// router.get('/',fetchProducts)
router.post('/create',upload.single('image'), createProduct)
router.post('/findproduct', findProduct);
router.get('/find', findProduct); 
router.get('/edit/:id',/*isOwnerLoggedIn,*/editProduct)
router.post('/update/:id',upload.single('image')/*,isOwnerLoggedIn*/, updateProduct)

module.exports = router