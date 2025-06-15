// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;


import {PriceConverter} from  "./PriceConverter.sol";


error NotOwner();

contract FundMe {
    using PriceConverter for uint;

    uint public  constant MINIMUM_USD = 1e18;
    address[] public founders;

    mapping (address funder => uint amountFunded) public addressToAmountFounded;

    address private  immutable i_owneradress;
   
    constructor(){

        i_owneradress = msg.sender;
    }
  
    

    function fund() public payable {

        //Have a minimum of usd 

        //El valor de msg value se pasa como parametro a la
        require(msg.value.getConversionRate() > MINIMUM_USD, "didn't send enough eth");
        founders.push(msg.sender);
        addressToAmountFounded[msg.sender] += msg.value;



    }

  

    function withdraw() public onlyOwner {

        
        for (uint i=0; i<founders.length; i++){
            address founder = founders[i];
            addressToAmountFounded[founder] = 0;
        }

        founders = new address[](0);

        //Transfer
        //payable (msg.sender).transfer(address(this).balance);
        // Send
        //require(payable (msg.sender).send(address(this).balance), "Send fail");
        //Call
        (bool callSucess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess, "Call failed");

    
    }
    
    // _; indica cuando ejecutara codigo, antes o despues
    modifier onlyOwner(){

        if(msg.sender != i_owneradress ){
            revert NotOwner();
        }

        //require(msg.sender == i_owneradress, "not allowed");
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }


}



