const bcrypt = require('bcrypt')
const userModel = require('../models/user')
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
                        response: createdUser
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
                response: user
            })
        } else {
            res.status(403).json({
                status: "Error",
                response: "Email or Password Incorrect"
            })
        }

    })

}

const logoutUser =  (req, res) => {
    res.cookie("token", "")
    res.status(200).json({
        status: "Success",
        response: "User logged out"
    })
}

module.exports = {registerUser,loginUser,logoutUser}