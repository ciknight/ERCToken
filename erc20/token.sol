pragma solidity ^0.4.23;

import 'browser/SafeMath.sol';
import 'browser/ERC20.sol';

contract Token is ERC20 {
  using SafeMath for uint;

    string internal _name;
    string internal _symbol;
    uint8 internal _decimals;
    uint256 internal _totalSupply;

    mapping (address => uint256) internal balances;

    // Notice that the function Token has the same name as the contract Token
    function Token(string name, string symbol, uint8 decimals, uint256 initialSupply) public {
        _symbol = symbol;
        _name = name;
        _decimals = decimals;
        _totalSupply = initialSupply * (10 ** uint256(_decimals));
        balances[msg.sender] = _totalSupply;
    }

    function name()
        public
        view
        returns (string) {
        return _name;
    }

    function symbol()
        public
        view
        returns (string) {
        return _symbol;
    }

    function decimals()
        public
        view
        returns (uint8) {
        return _decimals;
    }

    function totalSupply()
        public
        view
        returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
      return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
      require(_to != address(0));
      require(_value <= balances[msg.sender]);
      balances[msg.sender] = SafeMath.sub(balances[msg.sender], _value);
      balances[_to] = SafeMath.add(balances[_to], _value);
      Transfer(msg.sender, _to, _value);
      return true;
    }

}
