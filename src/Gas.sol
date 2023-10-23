// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
 
contract GasContract {
    address private constant CONTRACT_OWNER = address(0x1234);
    uint256 private constant BALANCE = 100;
    uint256 private _lastAmount;
    uint256 public totalSupply = 0; // cannot be updated
    uint256 public paymentCounter = 0;
    uint256 public tradePercent = 12;
    address public contractOwner;
    uint256 public tradeMode = 0;
    address[5] public administrators;
    bool public isReady = false;

    event AddedToWhitelist(address userAddress, uint256 tier);

    modifier onlyAdminOrOwner() {
        require(msg.sender == CONTRACT_OWNER);
        _;
    }

    event WhiteListTransfer(address indexed);

    constructor(address[] memory, uint256) payable { }


    function balanceOf(address) external pure returns (uint256) {
        return BALANCE;
    }

    function transfer(
        address,
        uint256,
        string calldata
    ) public returns (bool) { }

    function addToWhitelist(
        address _userAddrs,
        uint256 _tier
    ) external onlyAdminOrOwner {
        require(_tier < 255);
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(address _recipient, uint256 _amount) external {
        _lastAmount = _amount;
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address) external view returns (bool, uint256) {
        return (true, _lastAmount);
    }

    receive() external payable {
        payable(msg.sender).transfer(msg.value);
    }


    fallback() external payable {
         payable(msg.sender).transfer(msg.value);
    }
}