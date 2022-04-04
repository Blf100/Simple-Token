// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract SimpleCoin {
    uint256 public TotalSupply;

    mapping(address => uint256) public balanceOf;

    address public owner;

    string public name;

    string public simbol;

    uint256 public decimals;

    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        TotalSupply = 1_000_000 * 10**decimals;
        balanceOf[owner] = TotalSupply;

        name = "MaCoin";
        simbol = "LC";
        decimals = 8;
    }

    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool sucess)
    {
        require(balanceOf[msg.sender] >= _value, "There are not enough funds");
        require(_to != address(0));

        balanceOf[msg.sender] = balanceOf[msg.sender] - _value;
        balanceOf[_to] = balanceOf[_to] + _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool sucess) {
        require(allowance[_from][msg.sender] >= _value);
        require(balanceOf[_from] >= _value, "There are not enough funds");
        require(_to != address(0));
        require(_from != address(0));

        balanceOf[_from] = balanceOf[_from] - _value;
        balanceOf[_to] = balanceOf[_to] + _value;
        allowance[_from][msg.sender] - _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool sucess)
    {
        require(balanceOf[msg.sender] >= _value);
        require(_spender != address(0));

        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }
}
