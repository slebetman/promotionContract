var PrivateKeyProvider = require("truffle-privatekey-provider");
var privateKey = "c282e1c716d96b857edaecb121f29c765efadc816d6a63c65fbcd4ff0ae33ed0";

module.exports = {
  networks: {
    development: {
      provider: new PrivateKeyProvider(privateKey, "HTTP://127.0.0.1:7545"),
      network_id: '*'
    },
    mohammad: {
      provider: new PrivateKeyProvider(privateKey, "HTTP://192.168.1.7:7545"),
      network_id: '*'
    }
  }
};
