const e = require("express");
const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const authRouter = express.Router();

//Signup
authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;

        const existinguser = await User.findOne({ email });
        if (existinguser) {
            return res.status(400).json({ msg: "Email Already Exists!" });
        }
        const hashedpass = await bcryptjs.hash(password, 8);
        let user = User({
            name, email, password: hashedpass,
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});
//Signin
authRouter.post('/api/signin', async (req, res) => {
    console.log(req.body);
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "இந்த மின்னஞ்சலைக் கொண்ட பயனர் இல்லை!" });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "தவறான கடவுச்சொல்!" });
        }
        const token = jwt.sign({ id: user._id }, "passwordKey");

        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});

module.exports = authRouter;