const express = require("express");
const router = express.Router();

const relatedProductController = require("../controllers/related-product.controller");

router.post("/", relatedProductController.create);
router.delete("/:id", relatedProductController.delete);

module.exports = router;
