//SPDX-License-Identifier: MIT

//get funds from user
//withdraw funds
//set a min funding value in usd

//usefull tool - chainlink feed - can use the address as input for recieveinng the fucntionality of the contract 

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe{
    uint256 public minUsd = 1;
    function fund() public payable { 
        //send money to contract/ Allow user to send $/have a minimum $ sent
        //money are sended with the msg
        require(msg.value > 1, "didn't send enough ETH");
        //but can undo
    }
    // function withdraw() public {
    //     //owner will use to withdraw
    // }
    function getPrice() public view returns(uint256) {
        //need address and abi 
        // 0x694AA1769357215DE4FAC081bf1f309aDC325306 eth/usd
      //  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
      (,int256 price,,,) = priceFeed.latestRoundData();
      //eth to usd but 2000000000000000
      return uint256(price * 1e10);
    }


    //version works only with thetransactions from metanask (remix its just browser js no real testnets)
    function getVersion() public view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
    function getConversion() public {}
}