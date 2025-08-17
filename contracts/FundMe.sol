
// 791446 gas before 901665
//763635 constant 878181
//851603 immutable
//	823698 revert

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {converter} from "./converter.sol";
error NotOwner();

contract FundMe{

  //if in library fucntions first parametnr is uint256 allow me to call them as they are methods of uint256
  //solidity  just rewriting msg.value.getConverter() to converter.getConversion(msg.value)
  using converter for uint256;

    uint256 public constant MIN_USD = 5e18; // non need to change 
    address[] public funders;
    mapping(address => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;
  constructor() {
      i_owner = msg.sender;
  }
    function fund() public payable { 
        require(msg.value.getConversion() >=  MIN_USD,  "didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        //but can undo
    }

    function withdraw() public onlyOwner{
      //for loop
      for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;

      }
      // reseting array;
      funders = new address[](0);
      //send currency 
      //transfer - automatically reverts
      //need to cast address to payable address
      // payable(msg.sender).transfer(address(this).balance);
      // //send only if there is require
      // bool sendSuccess = payable (msg.sender).send(address(this).balance);
      // require(sendSuccess, "send failed");
      
      //call( calling virtually wothout  abi)
      (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
      require(callSuccess, "Call failed");
    }
    modifier onlyOwner() {
      if (msg.sender != i_owner) { revert NotOwner();}
      //whatever in the function
      _;
    }
    // if someone will send eth wothout fund 
    receive() external payable{
      fund();
    }
    fallback() external payable{
      fund();
    }
}