process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const environment = require('./environment');

let env = environment.toWebpackConfig();

env['devServer']['host'] = '0.0.0.0';

console.log(env);

module.exports = env;
