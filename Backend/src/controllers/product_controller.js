const ProductModel = require('../models/product_model')


const ProductController = {

    createProduct: async function(req,res){
        try{
            const productData = req.body;
            const newProduct = new ProductModel(productData);
            await newProduct.save();

            return res.json({success: true, data : newProduct, message: "Product created !"});
        }catch(err){
            return res.json({success: false, message: err})
        }
    },

    fetchAllProducts: async function(req,res){
        try{
            const products = await ProductModel.find();
            return res.json({success: true, data : products});
        }catch(err){
            return res.json({success: false, message: err})
        }
    },

    fetchProductsById: async function(req,res){
        try{
            const id = req.params.id;
            const foundProduct =  await ProductModel.findById(id);
            if(!foundProduct){
                return res.json({success: false, message: "No such Product Exist"})
            }

            return res.json({success: true, data: foundProduct})
        }catch(err){
            return res.json({success: false, message: err})
        }
    },
    fetchProductByCategory: async function(req,res){
        try{
            const categoryId = req.params.id;
            const products =  await ProductModel.find({category: categoryId});
            if(!products){
                return res.json({success: false, message: "No such Product Exist"})
            }

            return res.json({success: true, data: products})
        }catch(err){
            return res.json({success: false, message: err})
        }
    },

};

module.exports = ProductController;