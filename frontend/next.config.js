const path = require("path");

const nextConfig = {
  output: "standalone",

  // 🔥 Turbopack を完全無効化
  turbopack: {},

  experimental: {
    serverActions: {
      allowedOrigins: ["*"],
    },
  },

  webpack: (config) => {
    config.resolve.alias["@"] = path.resolve(__dirname);
    return config;
  },
};

module.exports = nextConfig;
