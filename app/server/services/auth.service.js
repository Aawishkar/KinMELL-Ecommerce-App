const { user } = require("../models/user.model");
const bcrypt = require("bcryptjs");
const auth = require("../middleware/auth.middleware");
const otpGenerator = require("otp-generator");
const crypto = require("crypto");
const key = "otp-secret-key";
const nodemailer = require("nodemailer");
async function login({ email, password }, callback) {
  const userModel = await user.findOne({ email });

  if (userModel != null) {
    if (bcrypt.compareSync(password, userModel.password)) {
      const token = auth.generateAccessToken(userModel.toJSON());
      return callback(null, { ...userModel.toJSON(), token });
    } else {
      return callback({
        message: "Invalid Email/Password",
      });
    }
  } else {
    return callback({
      message: "Invalid Email/Password",
    });
  }
}

async function singup(params, callback) {
  if (params.email === undefined) {
    return callback({
      message: "Email Required!",
    });
  }

  let isUserExist = await user.findOne({ email: params.email });

  if (isUserExist) {
    return callback({
      message: "Email already registered!",
    });
  }

  const salt = bcrypt.genSaltSync(10);
  params.password = bcrypt.hashSync(params.password, salt);

  const userSchema = new user(params);
  userSchema
    .save()
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}
async function createOtp(params, callback) {

  const otp = otpGenerator.generate(
    4,
    {
      lowerCaseAlphabets: false,
      upperCaseAlphabets: false,
      specialChars: false
    }
  );
  //const ttl= 5*60*1000;
  //const expires =Date.now()+ ttl;
  const data = params.email + otp;
  const hash = crypto.createHmac("sha256", key).update(data).digest("hex");
  const mailOptions =
  {
    from: "sudipbhattarai806@gmail.com",
    to: params.email,
    subject: "Verify Your Email",
    html: `<!doctype html>
    <!doctype html>
    <html lang="en-US">
    
    <head>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <title>Verfiy Your Email</title>
        <meta name="description" content="Verfiy Your Email">
        <style type="text/css">
            a:hover {text-decoration: underline !important;}
        </style>
    </head>
    
    <body marginheight="0" topmargin="0" marginwidth="0" style="margin: 0px; background-color: #f2f3f8;" leftmargin="0">
        <!--100% body table-->
        <table cellspacing="0" border="0" cellpadding="0" width="100%" bgcolor="#f2f3f8"
            style="@import url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700|Open+Sans:300,400,600,700); font-family: 'Open Sans', sans-serif;">
            <tr>
                <td>
                    <table style="background-color: #f2f3f8; max-width:670px;  margin:0 auto;" width="100%" border="0"
                        align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="height:80px;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align:center;">
                              
                                <img width="60" src="https://i.postimg.cc/bvTYbh4b/kinmell.png" title="logo" alt="logo">
                              </a>
                            </td>
                        </tr>
                        <tr>
                            <td style="height:20px;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0"
                                    style="max-width:670px;background:#fff; border-radius:3px; text-align:center;-webkit-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);-moz-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);box-shadow:0 6px 18px 0 rgba(0,0,0,.06);">
                                    <tr>
                                        <td style="height:40px;">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:0 35px;">
                                            <h1 style="color:#1e1e2d; font-weight:500; margin:0;font-size:32px;font-family:'Rubik',sans-serif;">You have
                                                requested to verify your mail</h1>
                                            <span
                                                style="display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece; width:100px;">${otp}</span>
                                            <p style="color:#455056; font-size:15px;line-height:24px; margin:0;">
                                                We have send you OTP(One Time Passowrd). Please Enter the OTP and proceed futher 
                                            </p>
                                          
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height:40px;">&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        <tr>
                            <td style="height:20px;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="text-align:center;">
                                <p style="font-size:14px; color:rgba(69, 80, 86, 0.7411764705882353); line-height:18px; margin:0 0 0;">&copy; <strong>KinMell</strong></p>
                            </td>
                        </tr>
                        <tr>
                            <td style="height:80px;">&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <!--/100% body table-->
    </body>
    </html>
       `,
  }
  let transporter = nodemailer.createTransport({
    service: 'gmail',

    auth:
    {
      user: "cekinmell@gmail.com",
      pass: "zundljojniarnvbd",
    }
  });


  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    }
    else {
      console.log("Email Sent Info");
    }
  });

  return callback(null, hash);
}

async function verifyOtp(params, callback) {

  let data = params.email + params.otp;
  let newCalculateHash = crypto.createHmac("sha256", key).update(data).digest("hex");
  if (newCalculateHash == params.hash) {
    return callback(null, "OTP VERIFIED");
  }
  else {
    return callback(null, "Invalid OTP");
  }
}
async function reset(params, callback) {

  const encrypted = bcrypt.hashSync(params.password, 10);
    const updated =await user.findOneAndUpdate({ email: params.email }, {
      $set: {
          password:encrypted
      }
  }, { lean: true })
   if(updated)
   {
    return callback(null,"Reset Successful");
   }
   else
   {
    return callback(null,"Reset Successful");
   }
  


}

module.exports = {
  login,
  singup,
  createOtp,
  verifyOtp,
  reset
};
