// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20 {
    mapping (address => uint256) private balances;
    mapping (address => mapping(address=>uint256)) private allowances;
    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint private _decimals;

    event Transfer(address from, address to, uint256 value);
    event Approval(address owner, address spender, uint256 value);

    constructor() {
        _name = "DREAM";
        _symbol = "DRM";
        _decimals = 18;
        _mint(msg.sender, 100 ether);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint) {
        return _decimals;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return balances[owner];
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return allowances[owner][spender];
    }

    function _mint(address to, uint256 value) public {
        require(to != address(0));
        balances[to] += value;
        _totalSupply += value;
    }

    function _burn(address to, uint256 value) public {
        require(to != address(0));
        require(balances[to] >= value);
        unchecked {
            balances[to] -= value;
            _totalSupply -= value;
        }
    }

    function transfer(address to, uint256 value) public {
        require(to != address(0));
        require(balances[msg.sender] >= value);
        unchecked {
            balances[msg.sender] -= value;
            balances[to] += value;
        }
        emit Transfer(msg.sender, to, value);
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowances[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public {
        require(balances[from] >= value);
        require(allowances[from][msg.sender] >= value);
        unchecked {
            balances[from] -= value;
            balances[to] += value;
            allowances[from][msg.sender] -= value;
        }
    }   
}