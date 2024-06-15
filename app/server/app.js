// importing npm modules
const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const morgan = require("morgan");
const cors = require("cors");
//importing local modules
const errors = require("./middleware/errors");
const authRoutes = require("./routes/auth.routes");
const categoryRoutes = require("./routes/category.routes");
const productRoutes = require("./routes/product.routes");
const relatedProductRoutes = require("./routes/related-product.routes");
const { config } = require("dotenv");
const app = express();
const PORT = process.env.PORT || 4000;
const host = "0.0.0.0";

require("dotenv").config();

//connecting to mongoDB
mongoose.Promise = global.Promise;
mongoose
  .connect(process.env.MONGO_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("database connected!");
  })
  .catch((error) => {
    console.log(error);
  });
//Nodemailer stuff



// automatic default logging middleware
app.use(morgan("common"));

//body parsing middleware
//app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// middleware
app.use(express.json());
app.use(cors());
app.use("/uploads", express.static("uploads"));

//Routes for handling requests
app.use("/api/auth", authRoutes);
app.use("/api/category", categoryRoutes);
app.use("/api/product", productRoutes);
app.use("/api/relatedProduct", relatedProductRoutes);

//error handling middleware
app.use(errors.errorHandler);

app.listen(PORT, host, () => {
  console.log(`server is running at http://${host}:${PORT}`);
});


module.exports = app;
