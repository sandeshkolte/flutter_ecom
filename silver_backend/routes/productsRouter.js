const express = require('express')
const {createProduct,updateProduct, getProduct, findProduct, editProduct, fetchProducts, deleteProduct} = require('../controller/productsController')
const { uploadProductImage } = require('../controller/imageController')
const { isOwnerLoggedIn } = require('../middlewares/isLoggedIn')
const router = express.Router()
const upload = require('../config/multer-config')

router.get('/',getProduct)
router.post('/upload-image', (req, res, next) => {
  upload.single('image')(req, res, (error) => {
    if (error) {
      const status = error.code === 'LIMIT_FILE_SIZE' ? 413 : 400;
      return res.status(status).json({ status: 'Error', response: error.message });
    }
    next();
  });
}, uploadProductImage)
// router.get('/',fetchProducts)
router.post('/create',isOwnerLoggedIn, createProduct)
router.post('/findproduct', findProduct);
router.get('/find', findProduct); 
router.get('/edit/:id',isOwnerLoggedIn,editProduct)
router.get('/delete/',isOwnerLoggedIn,deleteProduct)
router.post('/update/:id',isOwnerLoggedIn, updateProduct)

module.exports = router