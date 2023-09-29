//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Note the contract address of AggregatorV3Interface is valid for the Sepolia Testnet.

library ConvertPrice {
 function getPrice() internal view returns(uint256) {
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);  
      (,int price,,,) = priceFeed.latestRoundData();
      return uint256(price * 1e10);

      // Retrieves the price of the ethereum currency in the latest time space
      // Destructures the latestRoundData() function into price variable
      // Returns the uint256 value of price variable
    }

    function getVersion() internal view returns (uint256){
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
      return priceFeed.version();

      // Returns the version of the data feed
    }

    function getConversionRate(uint256 ethamount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethamount) /1e18;
        return ethAmountInUsd;

        // Returns the native ethereum currency into USD amount as per the latest value
    }
}