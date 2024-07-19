const bcrypt = require('bcrypt')
const ownerModel = require('../models/owner')
const { generateToken } = require('../utils/generateToken')

const createOwner = async (req, res) => {

    let { fullname, email, password, picture,brandName } = req.body

    let owners = await ownerModel.find({ email })
    if (owners.length > 0)
        return res.status(401).json({ status: "Error", response: "You owner already exist" })
    
    bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(password, salt, async (err, hash) => {

            if (err) return res.status(403).json({
                status: "Error",
                response: err.message
            })
            else {
                let createdOwner = ownerModel.create({
                    fullname, email, password, picture, brandName
                })

                const token = generateToken(createdOwner)
                res.cookie("token", token)

                res.status(201).json({
                    status: "Success",
                    response: createdOwner
                })

            }
        })
    })

}


const loginOwner = async (req, res) => {
    const { email, password } = req.body

    let user = await ownerModel.findOne({ email })

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


module.exports = {createOwner, loginOwner}