const path = require("path");

module.exports = {
  turbopack: {},

  webpack: (config) => {
    config.resolve.alias["@"] = path.resolve(__dirname);
    return config;
  },
};
