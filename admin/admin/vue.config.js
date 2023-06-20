// vue项目的配置文件 覆盖，
module.exports = {
  publicPath: './',
    lintOnSave: false,
    devServer: {
      open: true,
      port: 8082,
      overlay: false,
      proxy: {
        '/api': {
          target: 'http://localhost:8182/',
          changeOrigin: true,
          pathRewrite: {
            '^/api': ''
          }
        }
      }
    }

  }
