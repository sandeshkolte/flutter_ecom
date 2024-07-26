const express = require('express')
const {registerUser,loginUser,logoutUser, addtoCart, removeFromCart, addOrder, removeOrders, updateOrderStatus, getCart} = require('../controller/userController')

const router = express.Router()

router.post('/register',registerUser)
router.post('/login', loginUser)
router.get('/logout',logoutUser)
router.post('/addtocart', addtoCart);
router.post('/removecart', removeFromCart)
router.post('/addorder', addOrder);
router.post('/removeorder', removeOrders)
router.post('/updateorder', updateOrderStatus)
router.post('/getcart', getCart)

module.exports = router