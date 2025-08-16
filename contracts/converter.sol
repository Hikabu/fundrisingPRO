//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library converter{
    function getPrice() internal view returns(uint256) {
        //need address and abi 
        // 0x694AA1769357215DE4FAC081bf1f309aDC325306 eth/usd
      //  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
      (,int256 price,,,) = priceFeed.latestRoundData();
      //eth to usd but 2000000000000000
      return uint256(price * 1e10);
    }


    //version works only with thetransactions from metanask (remix its just browser js no real testnets)
    function getVersion() internal view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
    function getConversion(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        //IN solidity MULTIPLY GOES FIRST
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}