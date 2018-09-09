// THIS IS A MOCHA TEST - run using mocha

var Web3 = require('web3');
var config = require('../truffle-config.js');
var abi = require('../build/contracts/PromotionContract.json')
var truffleContract = require('truffle-contract');
var assert = require('assert');

var web3 = new Web3(config.networks.development.provider);

var Contract = truffleContract(abi);
Contract.setProvider(config.networks.development.provider);

var lastBalance = 0;

describe('Claims',function(){
	it('should allow user to claim',function(){
		return Contract.deployed()
			.then(promotion => {
				return web3.eth.getBalance(config.other_user)
					.then(balance => lastBalance = balance.toNumber())
					.then(promotion.claimPromotion(config.other_user))
					.then(web3.eth.getBalance(config.other_user))
					.then(balance => {
						assert(balance.toNumber() > lastBalance);
					});
			});
	});	
	
	// stop web3 manually:
	after(() => web3.currentProvider.engine.stop());
});
