//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ConvertPrice.sol";

contract Funding {
    using ConvertPrice for uint256;
    uint256 public MinimumUsd = 50 * 1e18;                               // Minimum amount in USD for fund

    address[] public funders;                                            // Array to store the wallet addresses of funders
    mapping(address => uint256) public addressToAmountFunded;            // Mapping to store the wallet address to amount funded relation
    address public owner;
    constructor(){
        owner = msg.sender;
    }

    function fund() public payable{
        require(msg.value.getConversionRate() >= MinimumUsd, "Insufficient ethers are being sent!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public OnlyOwner{
        for(uint256 funderIndex = 0;funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
         }
         funders = new address [](0);
         (bool CallSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
         require(CallSuccess,"Call failed!");  
    }

    modifier OnlyOwner{
        require(msg.sender == owner,"Sender is not the contract owner!");
        _ ;
      }

}