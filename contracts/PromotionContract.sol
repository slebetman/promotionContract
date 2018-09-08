pragma solidity ^0.4.23;

contract PromotionContract {
  address owner;
  uint reward;
  mapping (address => uint) public users;

  modifier onlyOwner () {
    if (msg.sender != owner) revert();
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

  function claimPromotion (address user) public onlyOwner {
    if (!isRegistered(user)) {
      user.transfer(reward * 133 * 1000);
	  LogClaim(user, reward * 133 * 1000);
    }
  }
}
