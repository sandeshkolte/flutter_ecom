const express = require('express')
const {createProduct,updateProduct, getProduct, findProduct, editProduct, fetchProducts, deleteProduct} = require('../controller/productsController')
const { isOwnerLoggedIn } = require('../middlewares/isLoggedIn')
const router = express.Router()
const upload = require('../config/multer-config')

router.get('/',getProduct)
// router.get('/',fetchProducts)
router.post('/create', createProduct)
router.post('/findproduct', findProduct);
router.get('/find', findProduct); 
router.get('/edit/:id',/*isOwnerLoggedIn,*/editProduct)
router.get('/delete',/*isOwnerLoggedIn,*/deleteProduct)
router.post('/update/:id',upload.single('image')/*,isOwnerLoggedIn*/, updateProduct)

module.exports = router