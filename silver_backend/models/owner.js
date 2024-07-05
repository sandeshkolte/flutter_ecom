const mongoose = require("mongoose");

const ownerSchema = mongoose.Schema({
    fullname: {
        type: String,
        minLength: 3,
        trim: true
    },
    brandName:String,
    email: String,
    password: String,
    products: {
        type: Array,
        default: []
    },
    picture: String,
}, {
    timestamps: true 
})

module.exports = mongoose.model("owner", ownerSchema)