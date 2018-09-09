// THIS IS A MOCHA TEST - run using mocha

var Web3 = require('web3');
var config = require('../truffle-config.js');
var abi = require('../build/contracts/PromotionContract.json')
var truffleContract = require('truffle-contract');
var assert = require('assert');

var web3 = new Web3(config.networks.development.provider);

var Contract = truffleContract(abi);
Contract.setProvider(config.networks.development.provider);

describe('Basic',function(){
	it('must be instantiable',function(){
		return Contract.deployed().then(promotion => {
			assert(promotion.address != undefined);
		});
	});	
	
	// stop web3 manually:
	after(() => web3.currentProvider.engine.stop());
});