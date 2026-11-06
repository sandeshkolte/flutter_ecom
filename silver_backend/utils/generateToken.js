const jwt = require('jsonwebtoken')

const generateToken = (user, role = 'user') => {
    return jwt.sign({ email: user.email, id: user._id, role }, process.env.JWT_SECRET)
}

module.exports.generateToken = generateToken