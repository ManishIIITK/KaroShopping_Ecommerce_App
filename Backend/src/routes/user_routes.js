const userRoutes = require('express').Router();
const userController = require('../controllers/user_controller');


userRoutes.post("/createAccount", userController.createAccount);
userRoutes.post("/signIn", userController.signIn);
userRoutes.put("/:id", userController.updateUser);

module.exports = userRoutes;