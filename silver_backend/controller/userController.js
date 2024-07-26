const bcrypt = require('bcrypt')
const userModel = require('../models/user')
const productModel = require('../models/product')
const {generateToken} = require('../utils/generateToken')

const registerUser =  async (req, res) => {

    const { username, email, password } = req.body

    let user = await userModel.findOne({ email })

    if (user) return res.status(403).json({
        status: "Error",
        response: "User already exist"
    })
    else {
        bcrypt.genSalt(10, (err, salt) => {
            bcrypt.hash(password, salt, async (err, hash) => {

                if (err) return res.status(403).json({
                    status: "Error",
                    response: err.message
                })
                else {
                    let createdUser = await userModel.create({
                        username, email, password: hash
                    })

                    const token = generateToken(createdUser)
                    res.cookie("token", token)

                    res.status(200).json({
                        status: "Success",
                        response: {createdUser,token}
                    })

                }
            })
        })
    }
}

const loginUser = async (req, res) => {
    const { email, password } = req.body

    let user = await userModel.findOne({ email })

    if (!user) return res.status(403).json({
        status: "Error",
        response: "Email or Password Incorrect"
    })

    bcrypt.compare(password, user.password, (err, result) => {
        if (result) {
            const token = generateToken(user)
            res.cookie("token", token)
            res.status(200).json({
                status: "Success",
                response: {user,token}
            })
        } else {
            res.status(403).json({
                status: "Error",
                response: "Email or Password Incorrect"
            })
        }

    })
}


const getCart = async (req,res) => {
    try{
const {userid} = req.query

let user = await userModel.findById(userid)

if (!user) return res.status(404).json({
    status: "Error",
    response: "User not found"
})

res.status(200).json({
    status:"success",
    response:user.cart
})

    }catch(e){


    }
}

const addtoCart = async (req, res) => {
    try {
        const { id, userid } = req.query;

        let product = await productModel.findOne({ _id:id });

        if (!product) return res.status(404).json({
            status: "Error",
            response: "Product not found"
        });

        let user = await userModel.findById(userid);

        if (!user) return res.status(404).json({
            status: "Error",
            response: "User not found"
        });

        user.cart.push(product);
        await user.save();

        res.status(200).json({
            status: "Success",
            response: "Cart updated"
        });

    } catch (e) {
        res.status(500).json({
            status: "Error",
            response: `Error: ${e.message}`
        });
    }
}


const addOrder = async (req, res) => {
    try {
        const { id, userid } = req.query;

        let product = await productModel.findOne({ _id:id });

        if (!product) return res.status(404).json({
            status: "Error",
            response: "Product not found"
        });

        let user = await userModel.findById(userid);

        if (!user) return res.status(404).json({
            status: "Error",
            response: "User not found"
        });

        user.orders.push(product);
        await user.save();

        res.status(200).json({
            status: "Success",
            response: "Orders updated"
        });

    } catch (e) {
        res.status(500).json({
            status: "Error",
            response: `Error: ${e.message}`
        });
    }
}

const updateOrderStatus = async (req, res) => {
    const { userId, orderId, newStatus } = req.query;

    console.log(`Received request to update order status: userId=${userId}, orderId=${orderId}, newStatus=${newStatus}`);

    try {
        let user = await userModel.findById(userId);

        if (!user) {
            console.log('User not found');
            return res.status(404).json({ success: false, message: 'User not found' });
        }

        console.log('User found:', user);

        let orderIndex = user.orders.findIndex(order => order._id.toString() === orderId);

        if (orderIndex === -1) {
            console.log('Order not found');
            return res.status(404).json({ success: false, message: 'Order not found' });
        }

        console.log('Order found at index:', orderIndex);

        user.orders[orderIndex].orderStatus = newStatus;
        user.markModified(`orders.${orderIndex}.orderStatus`); // Mark the specific subdocument as modified

        await user.save();

        console.log('Order status updated successfully');
        return res.status(200).json({ success: true, message: 'Order status updated successfully' });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ success: false, message: 'An error occurred while updating the order status' });
    }
};

const logoutUser =  (req, res) => {
    res.cookie("token", "")
    res.status(200).json({
        status: "Success",
        response: "User logged out"
    })
}

const removeFromCart = async (req, res) => {
    try {
        const { id, userid } = req.query;

        // Validate query parameters
        if (!id) {
            return res.status(400).json({
                status: "Error",
                response: "Missing id or email parameter"
            });
        }

        // Find the product by ID
        let product = await productModel.findById(id);
        if (!product) {
            return res.status(404).json({
                status: "Error",
                response: "Product not found"
            });
        }

        // Find the user by email
        let user = await userModel.findById(userid);
        if (!user) {
            return res.status(404).json({
                status: "Error",
                response: "User not found"
            });
        }

        // Remove the product from the user's cart by comparing _id fields
        user.cart = user.cart.filter(item => item._id.toString() !== product._id.toString());

        // Log the updated cart for debugging
        console.log(`User's updated cart: ${JSON.stringify(user.cart)}`);
        
        await user.save();

        res.status(200).json({
            status: "Success",
            response: "Cart updated"
        });

    } catch (e) {
        res.status(500).json({
            status: "Error",
            response: `Error: ${e.message}`
        });
    }
};

const removeOrders = async (req, res) => {
    try {
        const { id, userid } = req.query;

        // Validate query parameters
        if (!id) {
            return res.status(400).json({
                status: "Error",
                response: "Missing id or email parameter"
            });
        }

        // Find the product by ID
        let product = await productModel.findById(id);
        if (!product) {
            return res.status(404).json({
                status: "Error",
                response: "Product not found"
            });
        }

        // Find the user by email
        let user = await userModel.findById(userid);
        if (!user) {
            return res.status(404).json({
                status: "Error",
                response: "User not found"
            });
        }

        // Remove the product from the user's cart by comparing _id fields
        user.orders = user.orders.filter(item => item._id.toString() !== product._id.toString());

        // Log the updated cart for debugging
        console.log(`User's updated cart: ${JSON.stringify(user.orders)}`);
        
        await user.save();

        res.status(200).json({
            status: "Success",
            response: "Cart updated"
        });

    } catch (e) {
        res.status(500).json({
            status: "Error",
            response: `Error: ${e.message}`
        });
    }
};

module.exports = { registerUser, loginUser, logoutUser, addtoCart, removeFromCart,addOrder,removeOrders,updateOrderStatus,getCart };
