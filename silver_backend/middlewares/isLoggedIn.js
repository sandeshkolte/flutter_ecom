const jwt = require("jsonwebtoken")
const userModel = require("../models/user")
const ownerModel = require("../models/owner")

const isUserLoggedIn = async(req,res,next)=>{

if(!req.cookies.token) {

return  res.status(403).json({
   status:"Error",
   response: "You need to login first"
})
}
try{

   let decoded =  jwt.verify(req.cookies.token,process.env.JWT_SECRET)
   let user = await userModel.findOne({email:decoded.email}).select("-password")
req.user = user

next()
}catch(err){
   res.status(403).json({
      status:"Error",
      response: err.message
   })
}

}

const isOwnerLoggedIn = async(req,res,next)=>{
   if (!req.cookies.token) {
      return res.status(401).json({
         status: "Error",
         response: "Owner login required."
      })
   }

   try {
      const decoded = jwt.verify(req.cookies.token, process.env.JWT_SECRET)
      if (decoded.role !== "owner") {
         return res.status(403).json({
            status: "Error",
            response: "Owner access required."
         })
      }

      const owner = await ownerModel.findById(decoded.id).select("-password")
      if (!owner) {
         return res.status(401).json({
            status: "Error",
            response: "Owner account was not found."
         })
      }

      req.owner = owner
      next()
   } catch (err) {
      res.status(401).json({
         status: "Error",
         response: "Owner session is invalid or expired. Please log in again."
      })
   }
}

module.exports = {isUserLoggedIn, isOwnerLoggedIn}