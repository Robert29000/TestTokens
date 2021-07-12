// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract WBNB {
    using SafeMath for uint;

    string public name     = "Wrapped BNB";
    string public symbol   = "WBNB";
    uint8  public decimals = 18;

    event  Approval(address indexed src, address indexed guy, uint wad);
    event  Transfer(address indexed src, address indexed dst, uint wad);
    event  Deposit(address indexed dst, uint wad);
    event  Withdrawal(address indexed src, uint wad);

    mapping (address => uint)                       public  balanceOf;
    mapping (address => mapping (address => uint))  public  allowance;

    function() external payable {
        balanceOf[msg.sender] = balanceOf[msg.sender].add(msg.value);
        emit Deposit(msg.sender, msg.value);
        // Sorry for duplication. deposit() raising DeclarationError.
    }

    function deposit() external payable {
        balanceOf[msg.sender] = balanceOf[msg.sender].add(msg.value);
        emit Deposit(msg.sender, msg.value);
    }
    function withdraw(uint wad) external  {
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(wad);
        msg.sender.transfer(wad);
        emit Withdrawal(msg.sender, wad);
    }

    function totalSupply() public view returns (uint) {
        return address(this).balance;
    }

    function approve(address guy, uint wad) public returns (bool) {
        allowance[msg.sender][guy] = wad;
        emit Approval(msg.sender, guy, wad);
        return true;
    }

    function transfer(address dst, uint wad) external returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }

    function transferFrom(address src, address dst, uint wad)
    public
    returns (bool)
    {

        if (src != msg.sender && allowance[src][msg.sender] != uint(-1)) {
            allowance[src][msg.sender] = allowance[src][msg.sender].sub(wad);
        }

        balanceOf[src] = balanceOf[src].sub(wad);
        balanceOf[dst] = balanceOf[dst].add(wad);

        emit Transfer(src, dst, wad);

        return true;
    }
}