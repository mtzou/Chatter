var twilio = require('twilio');
require('dotenv').config();

var accountSid = process.env.TWILIO_ACCOUNT_SID;
var authToken = process.env.TWILIO_AUTH_TOKEN;
var twilioNumber = process.env.TWILIO_NUMBER
var client = new twilio(accountSid, authToken);

var exports = module.exports = {};

exports.sendMessage = async function sendMessage(_to, msg, delay) {
    await sleep(delay * 1000)
    client.messages.create({
        body: msg,
        to: _to,
        from: twilioNumber
    }).then((message) => {
        return "success"
    }).catch(function () {
        return "fail"
    });
};

async function sleep(millis) {
    return new Promise(function (resolve, reject) {
        setTimeout(function () { resolve(); }, millis);
    })
}

// TEST: run node texter.js
// exports.sendMessage('13215446737', 'hello world', 1)