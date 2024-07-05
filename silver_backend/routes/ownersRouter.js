const express = require('express')
const {createOwner, loginOwner}= require('../controller/ownersController')

const router = express.Router()

router.post('/create',createOwner)
router.post('/login',loginOwner)

module.exports = router