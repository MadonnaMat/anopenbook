const {environment} = require('@rails/webpacker');
const vue = require('./loaders/vue');
const jsYamlLoader = require('./loaders/js-yaml-loader');
const webpack = require('webpack');

environment.loaders.append('vue', vue);
environment.loaders.append('js-yaml-loader', jsYamlLoader);
environment.plugins.insert(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
  }),
);
module.exports = environment;
