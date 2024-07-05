const mongoose = require('mongoose')

const userSchema= mongoose.Schema({
username:String,
email:String,
password:String,
cart:{
    type: Array,
    default: []
},
orders: {
    type: Array,
    default: []
},
contact: Number,

}, {
    timestamps: true 
})

module.exports = mongoose.model("user",userSchema)