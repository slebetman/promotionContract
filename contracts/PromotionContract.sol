pragma solidity ^0.4.23;

contract PromotionContract {
  address owner;
  mapping (address => uint) public users;

  constructor () public {
    owner = msg.sender;
  }
}
