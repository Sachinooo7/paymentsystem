



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract project {
    
    event Received(address indexed from, uint amount);
    event Withdraw(address indexed to, uint amount);

    
    address public owner;

   
    constructor() {
        owner = msg.sender;
    }

   
    function makePayment() external payable {
        require(msg.value > 0, "Payment must be greater than zero");
        emit Received(msg.sender, msg.value);
    }

    function withdrawPayments(uint val) external payable {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        uint balance = address(this).balance;
        if(balance<val)
        {
            revert("Insufficient funds for withdrawal");
        }
        
        payable(owner).transfer(val);
        emit Withdraw(owner, val);
    }

    function getBalance() external view returns (uint) {
        assert(address(this).balance>0);
        return address(this).balance;
    }
}
