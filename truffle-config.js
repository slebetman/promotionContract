var PrivateKeyProvider = require("truffle-privatekey-provider");

//var privateKey = "af450b60613cf75983ba59398cc29c1b550e0115a4bdf5e14286d449aff259f9"; // OWNER
//var privateKey = '9405ebf7b48e6d18d57abee9ef4455771c59113f476a376a214bc5d06e662140'; // AGENT

// var privateKey = '0x3f723582fcb20c0217836d177a8e3606b8cae510302dbc0820b3ccff070a2da5';

//var Provider = require('truffle-hdwallet-provider');
//var recovery = 'bullet treat toss enjoy need flash trust local tribe rug olive limb';

var privateKey= 'e2860299fa975443084938bab892e22e195b3ba5d670b978b16dd72c7ed1bf63';

module.exports = {
  networks: {
    development: {
      provider: new PrivateKeyProvider(privateKey, "HTTP://127.0.0.1:8545"),
      network_id: '*'
    }
  },
  other_user: '0xb348434C8EC2e44Ac328B511384898fcBC657757'
};
