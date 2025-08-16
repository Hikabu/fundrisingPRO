//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {converter} from "./converter.sol";

contract FundMe{
  //if in library fucntions first parametnr is uint256 allow me to call them as they are methods of uint256
  //solidity  just rewriting msg.value.getConverter() to converter.getConversion(msg.value)
  using converter for uint256;

    uint256 public minUsd = 4e18;
    address[] public funders;
    mapping(address => uint256 amountFunded) public addressToAmountFunded;
    function fund() public payable { 
        require(msg.value.getConversion() >= minUsd,  "didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        //but can undo
    }

    function withdraw() public {
      //for loop
      for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;

      }
    }
}