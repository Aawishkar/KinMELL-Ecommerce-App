const mongoose = require("mongoose");

const user = mongoose.model(
  "User",
  mongoose.Schema(
    {
      //_id: mongoose.Schema.Types.ObjectId,
      name: {
        type: String,
        required: true,
        min: 3,
        max: 25,
        trim: true,
      },
      email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        match:
          /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/,
      },
      password: { type: String, required: true, trim: true },
      profilePicture: {
        type: String,
        default: "",
      },
      coverPicture: {
        type: String,
        default: "",
      },
      desc: {
        type: String,
        max: 50,
      },
      followers: {
        type: Array,
        default: [],
      },
      followings: {
        type: Array,
        default: [],
      },
      from: {
        type: String,
        max: 50,
      },
      location: {
        type: String,
      },
    },
    {
      toJSON: {
        transform: (doc, ret) => {
          ret.userId = ret._id.toString();
          delete ret._id;
          delete ret.__v;
          delete ret.password;
        },
      },
    },
    { timestamps: true }
  )
);

module.exports = { user };
