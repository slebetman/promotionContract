var Promotions = artifacts.require("./PromotionContract.sol");

module.exports = function(deployer) {
  deployer.deploy(Promotions);
};
