'use strict';
var path = require('path');
var reqdir = require('require-dir');


module.exports =  {
    // TODO: autoload?
    globals: reqdir(path.join(__dirname, '..', 'globals')),
    handlers: reqdir(path.join(__dirname, '..', 'handlers')),
    loaders: reqdir(path.join(__dirname, '..', 'loaders')),
    plugins: reqdir(path.join(__dirname, '..', 'plugins')),
}
