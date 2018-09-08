pragma solidity ^0.4.23;

contract PromotionContract {
  address owner;
  mapping (address => uint) public users;

  modifier onlyOwner () {
    if (msg.sender != owner) throw;
    _;
  }

  constructor () public {
    owner = msg.sender;
  }

  function isRegistered (address user) public returns (bool) {
    if (users[user] != 0) {
      return true;
    }
    return false;
  }  
}
