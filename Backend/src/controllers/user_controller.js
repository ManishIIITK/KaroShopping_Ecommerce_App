const userModel = require('../models/user_model')
const bcrypt = require('bcrypt');

const userController = {
    createAccount: async function(req,res){
        try{
            const userData = req.body;
            const newUser = new userModel(userData);
            await newUser.save();

            return res.json({success: true, data: newUser, message: "user created"})

        }catch(err){
            return res.json({success: false, message: err})
        }
    },
    signIn: async function(req,res){
        try{
            const {email, password} = req.body;

            const foundUser = await userModel.findOne({email: email});

            if (!foundUser){
                return res.json({success: false, message: "User does not exist"});
            }

            const passwordMatch = bcrypt.compareSync(password, foundUser.password);
            if(!passwordMatch){
                return res.json({success: false, message: "Incorrect Password"});
            }

            return res.json({success: true, data: foundUser})

        }catch(err){
            return res.json({success: false, message: err})
        }
    },

    updateUser: async function(req,res){
        try{
            const userId = req.params.id;
            const updateData = req.body;

            const updatedUser = await userModel.findOneAndUpdate(
                {_id: userId},
                updateData,
                {new: true}
            );

            if(!updatedUser){
                throw "User not found!1";
            }
            return res.json({success: true, data: updatedUser, message:"user updated"});
        }
        catch(err){
            return res.json({success: false, message: err})
        }
    }
}


module.exports = userController;