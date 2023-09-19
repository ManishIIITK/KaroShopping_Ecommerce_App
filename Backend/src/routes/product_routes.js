const ProductRoutes = require('express').Router();

const ProductController = require('../controllers/product_controller');

ProductRoutes.get("/", ProductController.fetchAllProducts);
ProductRoutes.get("/:id", ProductController.fetchProductsById);
ProductRoutes.get("/category/:id", ProductController.fetchProductByCategory);
ProductRoutes.post("/", ProductController.createProduct);

module.exports =  ProductRoutes;  