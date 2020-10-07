const path = require('path');

module.exports = {
    entry: './index.ts',
    mode: 'production',
    output: {
        path: path.join(__dirname, 'build'),
        filename: 'index.js'
    },
    target: 'node',
    module: {
        rules: [
            {
                test: /\.ts?$/,
                use: 'ts-loader',
                exclude: /node_modules/
            }
        ]
    },
    resolve: {
        extensions: ['.ts', '.js']  
      },
    node: {
        __dirname: false,
        __filname: false
    }
}