// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;


contract Ownable {

    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    address public owner;

    constructor() public{
        owner = msg.sender;
    }

    modifier OnlyOwner() {
        require(msg.sender == owner);
        _ ;
    }

    function transferOwnerShip(address newOwner) public OnlyOwner {
        require(newOwner != address(0), "Address can't be zero");
        owner = newOwner;

        emit OwnerChanged(msg.sender, newOwner);
    }
}