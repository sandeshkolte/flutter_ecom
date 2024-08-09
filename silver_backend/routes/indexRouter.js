const express = require('express')
const {home,createProdpage} = require('../controller/indexController')
const router = express.Router()

router.get('/',home)
// router.get('/createproduct',createProdpage)

module.exports = router