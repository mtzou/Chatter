const express = require('express');
const app = express();
var texter = require('./texter.js');


app.get('/', (req, res) => res.send('Hello World!') );

app.get('/user/:id', function(req, res) {
    res.send('user ' + req.params.id);
  });


app.post('/send', function(req, res) {
    // console.log(req.url)
    // console.log(res)
    console.log(req.body)
    var query = require('url').parse(req.url,true).query;
    console.log("INDEXJS: " + 'Sending: ' + query.msg + ' to: ' + query.to + ' with delay: ' + query.delay)
    res.send('Sending: ' + query.msg + ' to: ' + query.to + ' with delay: ' + query.delay);
    texter.sendMessage(query.to, query.msg, query.delay)
});

app.get('/send', function(req, res) {
    var query = require('url').parse(req.url,true).query;
    texter.sendMessage(query.to, query.msg, query.delay)
    res.send("received")
    // todo implement fail / receive 
});

app.listen(3000, () => console.log('Server listening on port 3000!') );
