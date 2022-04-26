const functions = require('firebase-functions');
const nodemailer = require('nodemailer');
var serviceAccount = require("./test_credentials.json");
//to do once billing enabled: firebase functions:config:set gmail.email="myusername@gmail.com" gmail.password="secretpassword"

const gmailEmail = serviceAccount.login;
//functions.config().gmail.email;
const gmailPassword = serviceAccount.password;
//functions.config().gmail.password;
const mailTransport = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: gmailEmail,
    pass: gmailPassword,
  },
});
const APP_NAME = 'firequiz';

exports.sendWelcomeEmail = functions.auth.user().onCreate((user) => {
  const email = user.email;
  const displayName = user.displayName;
  return sendWelcomeEmail(email, displayName);
});

async function sendWelcomeEmail(email, displayName) {
  const mailOptions = {
    from: `${APP_NAME} <noreply@firebase.com>`,
    to: email,
  };
  mailOptions.subject = `Welcome to ${APP_NAME}!`;
  mailOptions.text = `Hey ${displayName || ''}! Welcome to ${APP_NAME}. I hope you will enjoy our service.`;
  await mailTransport.sendMail(mailOptions);
  functions.logger.log('New welcome email sent to:', email);
  return null;
}
