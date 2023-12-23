// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Savings {
    address public owner;
    mapping(address => uint) public balances;

    event Deposit(address account, uint amount);
    event Withdrawal(address account, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");

        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint _amount) external onlyOwner {
        require(_amount > 0, "Withdrawal amount must be greater than 0");
        require(_amount <= balances[msg.sender], "Insufficient funds");

        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;

        emit Withdrawal(msg.sender, _amount);
    }

    function getBalance() external view returns (uint) {
        return balances[msg.sender];
    }

    function contractBalance() external view onlyOwner returns (uint) {
        return address(this).balance;
    }
}