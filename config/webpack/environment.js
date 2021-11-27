const { environment } = require("@rails/webpacker");
const { VueLoaderPlugin } = require("vue-loader");
const vue = require("./loaders/vue");
const eslint = require("./loaders/eslint");

const webpack = require("webpack");

environment.plugins.prepend("Provide",
  new webpack.ProvidePlugin({
    $: "jquery/src/jquery",
    jQuery: "jquery/src/jquery"
  })
);

environment.plugins.prepend("VueLoaderPlugin", new VueLoaderPlugin());
environment.loaders.prepend("vue", vue);
environment.loaders.prepend("eslint", eslint);
module.exports = environment;
