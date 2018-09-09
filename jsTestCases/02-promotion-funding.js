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
var testFunding = 12345;

describe('Funding',function(){
	var owner = config.networks.development.provider.address;

	it('should return a balance',function(){
		return Contract.deployed()
			.then(promotion => promotion.balance())
			.then(balance => {
				lastBalance = balance.toNumber();
				assert.equal(typeof balance.toNumber(), 'number');
			});
	});	
	
	it('should accept funding',function(){
		return Contract.deployed()
			.then(promotion => {
				return web3.eth.sendTransaction({
						from: owner, 
						to: promotion.address, 
						value: testFunding
					})
					.then (promotion.balance)
					.then(balance => {
						assert.equal(balance.toNumber() - testFunding, lastBalance);
					});
			});
	});
	
	it('allow owner to withdraw',function(){
		return Contract.deployed()
			.then(promotion => {
				var ownerBalance = 0;
				
				return web3.eth.getBalance(owner)
					.then(balance => ownerBalance = balance)
					.then(() => promotion.withdraw(
						owner,
						testFunding
					))
					.then(() => web3.eth.getBalance(owner))
					.then(balance => {
						assert.equal(
							balance.toNumber(),
							ownerBalance.add(testFunding).toNumber()
						);
					});
			});
	});
	
	// stop web3 manually:
	after(() => web3.currentProvider.engine.stop());
});
