const router = require("express").Router();
const mongoose = require("mongoose");

router.get("/", (req, res) => {
  res.send({ message: "User Router" });
});

module.exports = router;
