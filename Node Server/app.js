// import express JS Module into App 
// and creates its variable. 
var express = require('express')
var fs = require('fs'); 
var app = express()
const port = process.env.PORT || 3000
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

var imagePath = 'default'

// Creates a server which runs on port 3000 and 
// can be accessed through localhost:3000 
app.listen(port, function () {
    console.log('Server started on PORT: 3000...');
})

// Function callName() is executed whenever 
// url is of the form localhost:3000/name 
app.get('/result', callName);

function callName(req, res) {

    // Use child_process.spawn method from 
    // child_process module and assign it 
    // to variable spawn 
    var spawn = require("child_process").spawn;

    var process = spawn('python', ["./hello.py",
        imagePath]);

    // Takes stdout data from script which executed 
    // with arguments and send this data to res object 
    process.stdout.on('data', function (data) {
    
        var distance = data.toString();
        // distance = distance.replace("\r\n","")
        res.send({distance: distance})
        imagePath = 'default'
    })
}

// flutter code for upload image to backend node js 
app.post("/image", function(req, res) {
    var name = req.body.name;
    var img = req.body.image;
    var realFile = Buffer.from(img, "base64");

    fs.writeFile(name, realFile, function (err) {
        if (err)
            console.log(err);
    });

    imagePath = name

    res.send({ message: 'Image Uploaded'})

});
