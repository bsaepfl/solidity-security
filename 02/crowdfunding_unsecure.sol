pragma solidity ^0.4.25;

contract Crowdfunding {

  mapping(address => uint) public balances;
  address public owner;
  uint256 INVEST_MIN = 1 ether;
  uint256 INVEST_MAX = 10 ether;
  uint256 HARD_CAP = 100 ether;
  uint256 amount_contributed = 0;

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function crowdfunding() {
    owner = msg.sender;
  }

  function withdrawfunds() public onlyOwner {
    msg.sender.transfer(this.balance);
  }

  function invest() public payable {
    if(amount_contributed + msg.value < HARD_CAP){
      require(msg.value > INVEST_MIN && msg.value < INVEST_MAX);
      amount_contributed = amount_contributed + msg.value;
      balances[msg.sender] += msg.value;
    }
  }

  function getBalance() public constant returns (uint) {
    return balances[msg.sender];
  }

}
