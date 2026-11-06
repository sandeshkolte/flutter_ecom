const express = require('express')
const {createOwner, loginOwner, getCurrentOwner, logoutOwner}= require('../controller/ownersController')
const { isOwnerLoggedIn } = require('../middlewares/isLoggedIn')

const router = express.Router()

router.post('/create',createOwner)
router.post('/login',loginOwner)
router.get('/me',isOwnerLoggedIn,getCurrentOwner)
router.post('/logout',logoutOwner)

module.exports = router