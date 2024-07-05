const express = require('express')
const {createProduct,updateProduct, getProduct} = require('../controller/productsController')
const router = express.Router()
// const upload = require('../config/multer-config')

router.get('/',getProduct)
router.post('/create', createProduct)
router.post('/update/:id', updateProduct)

module.exports = router