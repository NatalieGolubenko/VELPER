

pragma solidity ^0.4.18;

import "https://github.com/OpenZeppelin/zeppelin-solidity/contracts/token/MintableToken.sol";

contract VLPRToken is MintableToken
{
    string public constant name = "VELPER EARLY BIRD";
    string public constant symbol = "VLPR";
    uint8 public constant decimals = 18;
}

contract Crowdsale
{
    using SafeMath for uint256;
    
    VLPRToken public token;
    address public constant wallet = 0x9eCf1Ed03e482C5f59CCB24868E8CD8F91f80d66;
    uint256 public constant end = 1526817600;
    uint256 public constant rate = 400;
    uint256 public constant minAmount = 1000000000000000000;
    
    function Crowdsale() public
    {
        token = new VLPRToken();
    }
    
    function () public payable 
    {
        require(msg.sender != address(0));
        require(msg.value > 0);
        require(now < end);
        
        uint256 weiAmount = msg.value;
        uint256 tokens = weiAmount.mul(rate);
        
        require(tokens >= minAmount);
        
        token.mint(msg.sender, tokens);
        wallet.transfer(msg.value);
    }
}
