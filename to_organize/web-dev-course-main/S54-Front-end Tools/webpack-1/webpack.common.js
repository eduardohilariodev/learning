// https://www.udemy.com/course/web-development-html5-css3-php-oop-and-mysql-database/learn/lecture/8551574#content
const Path = require("path");
const Webpack = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  mode: "development",
  entry: "./src/entry.js",
  output: {
    path: Path.resolve(__dirname, "dist"),
    filename: "bundle.js",
    // publicPath: "./", remove the ./ when using web-dev-server
    publicPath: "",
    clean: true,
  },
  optimization: {
    minimize: true,
  },
  plugins: [
    new Webpack.BannerPlugin("Hello from bult-in plugin: Banner Plugin"),
    new HtmlWebpackPlugin({
      template: "./template.html",
    }),
  ],
  module: {
    rules: [
      {
        // Configuring CSS
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
      {
        // Configuring images
        test: /\.(jpg|jpeg|png|gif)&/,
        use: {
          loader: "file-loader",
          options: {
            name: "[name].[ext]",
          },
        },
      },
    ],
  },
};
