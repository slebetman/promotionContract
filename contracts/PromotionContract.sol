pragma solidity ^0.4.23;

contract PromotionContract {
  address owner;
  uint reward = 19;
  mapping (address => uint) public users;
  mapping (address => uint) agents;
  mapping (address => uint) allowed_contracts; // mechanism to allow other contracts to call functions

  modifier onlyOwner () {
    if (msg.sender != owner) revert();
    _;
  }
  
  modifier onlyPermitted () {
	if (msg.sender != owner && allowed_contracts[msg.sender] == 0) revert();
	_;
  }

  constructor () public {
    owner = msg.sender;
  }

  event LogBargTopUp (address from, uint value);
  event LogClaim (address user, uint value);

  // ALLOW PEOPLE TO TOP-UP this smart contract.
  function () public payable {
    emit LogBargTopUp(msg.sender, msg.value);
  }

  function isRegistered (address user) public view returns (bool) {
    if (users[user] != 0) {
      return true;
    }
    return false;
  }

  function claimPromotion (address user) public onlyPermitted {
    if (!isRegistered(user)) {
      user.transfer(reward * 133 * 1000);
	  users[user] = 1;
	  LogClaim(user, reward * 133 * 1000);
    }
  }
  
  function allow (address other) public onlyOwner {
	allowed_contracts[other] = 1;
  }
  
  function disallow (address other) public onlyOwner {
	allowed_contracts[other] = 0;
  }
  
  function appointAgent (address agent) public onlyOwner {
	agents[agent] = 1;
  }

  function removeAgent (address agent) public onlyOwner {
	agents[agent] = 0;
  }
  
  function setReward (uint value) public onlyOwner {
	reward = value;
  }
}
