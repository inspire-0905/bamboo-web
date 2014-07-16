var http = require('http');
var cp = require('child_process');

http.createServer(function (req, res) {
    req.on('end', function () {
        cp.exec('git pull', {cwd: '/data/apps/bamboo-web/'}, function(err, stdout, stderr) {
            res.writeHead(200, {'Content-Type': 'text/plain'});
            res.end(stdout + '\n\n' + stderr);
        });
    });
}).listen(8000, '0.0.0.0');