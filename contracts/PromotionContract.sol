pragma solidity ^0.4.23;

contract PromotionContract {
  // NOTE: These values are in AVAND!
  uint public reward = 0.01 ether; //19;
  uint public rewardWithAgent = 0.1 ether; //38;
  uint public agentIncentive = 0.1 ether; //38;
  
  address owner;
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
  event LogAlreadyClaimed (address user);
  event LogNotAnAgent (address agent);
  event LogAgentClaim (address user, address agent, uint userValue, uint agentValue);
  event LogFailedTransfer (address user);

  // ALLOW PEOPLE TO TOP-UP this smart contract.
  function () public payable {
    emit LogBargTopUp(msg.sender, msg.value);
  }
  
  // ALLOW OWNER TO WITHDRAW from this smart contract.
  function withdraw (address to, uint value) public onlyOwner {
	to.send(value);
  }

  function isRegistered (address user) public view returns (bool) {
    if (users[user] != 0) {
      return true;
    }
    return false;
  }
  
  function isAgent (address agent) public view returns (bool) {
    if (agents[agent] != 0) {
      return true;
    }
    return false;
  }
  
  function registerUser (address user) private {
	users[user] = 1;
  }

  function claimPromotion (address user) public onlyPermitted returns (bool success){
    if (!isRegistered(user)) {
      user.transfer(reward * 133 * 1000);
	  registerUser(user);
	  emit LogClaim(user, reward * 133 * 1000);
	  return true;
    }
	else {
		emit LogAlreadyClaimed(user);
		return false;
	}
  }
  
  function claimFromAgent (address agent, address user) public onlyPermitted returns (bool success) {
	if (isAgent(agent)) {
		if (!isRegistered(user)) {
			user.transfer(rewardWithAgent * 133 * 1000);
			agent.transfer(agentIncentive * 133 * 1000);
			registerUser(user);
			emit LogAgentClaim(user,msg.sender,rewardWithAgent,agentIncentive);
			return true;
		}
		else {
			emit LogAlreadyClaimed(user);
			return false;
		}
	}
	else {
		emit LogNotAnAgent(msg.sender);
		return false;
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
  
  function setRewardFromAgent (uint value) public onlyOwner {
	rewardWithAgent = value;
  }
  
  function setIncentiveToAgent (uint value) public onlyOwner {
	agentIncentive = value;
  }
  
  function balance () public view onlyPermitted returns (uint) {
	return uint(address(this).balance);
  }
}

