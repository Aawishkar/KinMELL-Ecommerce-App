const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads/products");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  },
});

const fileFilter = (req, file, callback) => {
  const validExts = [".png", ".jpg", ".jpeg"];
  if (!validExts.includes(path.extname(file.originalname))) {
    return callback(new Error("Only .png, .jpg and .jpeg format are allowed"));
  }

  const fileSize = parseInt(req.headers["content-length"]);

  if (fileSize > 10485760) {
    return callback(new Error("File Size Big"));
  }

  callback(null, true);
};

let upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  fileSize: 10485760,
});

module.exports = upload.single("productImage");
