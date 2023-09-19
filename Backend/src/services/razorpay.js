const razorpay = require("razorpay");

const instance = new razorpay({
    key_id: 'rzp_test_Q5vuohVxkYRO1B',
    key_secret: 'LtqrPcbylftJxIFdLgzCXe0H'
});

module.exports = instance;