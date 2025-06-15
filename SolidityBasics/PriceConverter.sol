// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

      function getPrice() internal  view  returns(uint){
        //Adress 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        // ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint(price * 1e10);

    }

    function getConversionRate(uint ethAmount) internal  view  returns (uint){
        uint ethPrice = getPrice();
        //No decimals, first multiply then divide
        return  (ethPrice * ethAmount)/ 1e18;


    }

    function getVersion () internal  view returns(uint) {
        return  AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version();
    }
}