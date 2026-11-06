const bcrypt = require('bcrypt')
const ownerModel = require('../models/owner')
const { generateToken } = require('../utils/generateToken')

const ownerCookieOptions = {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax',
    maxAge: 24 * 60 * 60 * 1000,
}

const createOwner = async (req, res) => {

    let { fullname, email, password, picture,brandName } = req.body

    let owners = await ownerModel.find({ email })
    if (owners.length > 0)
        return res.status(401).json({ status: "Error", response: "You owner already exist" })
    
    const hash = await bcrypt.hash(password, 10)
    const createdOwner = await ownerModel.create({
        fullname, email, password: hash, picture, brandName
    })

    const token = generateToken(createdOwner, 'owner')
    res.cookie("token", token, ownerCookieOptions)

    res.status(201).json({
        status: "Success",
        response: {
            id: createdOwner._id,
            fullname: createdOwner.fullname,
            email: createdOwner.email,
            brandName: createdOwner.brandName,
            picture: createdOwner.picture,
        }
    })

}


const loginOwner = async (req, res) => {
    const { email, password } = req.body

    if (!email || !password) {
        return res.status(400).json({
            status: "Error",
            response: "Email and password are required."
        })
    }

    const owner = await ownerModel.findOne({ email })

    if (!owner) return res.status(401).json({
        status: "Error",
        response: "Email or Password Incorrect"
    })

    const passwordMatches = await bcrypt.compare(password, owner.password)
    if (!passwordMatches) {
        return res.status(401).json({
            status: "Error",
            response: "Email or Password Incorrect"
        })
    }

    const token = generateToken(owner, 'owner')
    res.cookie("token", token, ownerCookieOptions)
    res.status(200).json({
        status: "Success",
        response: {
            id: owner._id,
            fullname: owner.fullname,
            email: owner.email,
            brandName: owner.brandName,
            picture: owner.picture,
        }
    })
}

const getCurrentOwner = (req, res) => {
    const { _id, fullname, email, brandName, picture } = req.owner
    res.status(200).json({
        status: "Success",
        response: { id: _id, fullname, email, brandName, picture }
    })
}

const logoutOwner = (req, res) => {
    res.clearCookie("token", {
        httpOnly: ownerCookieOptions.httpOnly,
        secure: ownerCookieOptions.secure,
        sameSite: ownerCookieOptions.sameSite,
    })
    res.status(200).json({ status: "Success", response: "Logged out." })
}

module.exports = { createOwner, loginOwner, getCurrentOwner, logoutOwner }