const express = require('express');
const bodyParser = require('body-parser');
const helmet = require('helmet');
const morgan = require('morgan');
const cors = require('cors'); 
const mongoose = require('mongoose');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());


mongoose.connect("mongodb+srv://mmanishkumar0709:admin123@cluster0.3ivhoda.mongodb.net/ecommerce?retryWrites=true&w=majority")

const userRoutes = require('./routes/user_routes');
app.use('/api/user', userRoutes);

const CategoryRoutes = require('./routes/category_routes');
app.use('/api/category', CategoryRoutes);

const ProductRoutes = require('./routes/product_routes');
app.use('/api/product', ProductRoutes);

const cartRoutes = require('./routes/cart_routes');
app.use('/api/cart', cartRoutes);

const OrderRoutes = require('./routes/order_routes');
app.use('/api/order', OrderRoutes);


const PORT = 5000;
app.listen(PORT , ()=>{
    console.log(`Server started at PORT : ${PORT}`);
}); 

// Users -> Model, Routes, and Controller