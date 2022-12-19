const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const authrouter = require("./routes/auth");

const PORT = 3000;
const app = express();
const DB = "Your Mongo DB Link";

//middleware
app.use(cors());
app.use(express.json());
app.use(authrouter);

//mongoose coonection
mongoose.set('strictQuery', true);
mongoose.connect(DB).then(() => {
    console.log("Connection Sucessful");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected to port at ${PORT}`);
});


