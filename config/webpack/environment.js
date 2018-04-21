const {environment} = require('@rails/webpacker');
const vue = require('./loaders/vue');
const webpack = require('webpack');

environment.loaders.append('vue', vue);
environment.plugins.insert(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
  }),
);
module.exports = environment;
