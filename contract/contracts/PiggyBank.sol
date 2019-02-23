pragma solidity ^0.5.0;

contract PiggyBank {

    address public sender;
    address payable public receiver;
    address public constant approver = 0x107cec7777c0CBA5f9A9AdB0E64696f93Cb45FF8;

    function deposit() external payable {
        require(msg.value > 0);
        sender = msg.sender;
    }

    function viewApprover() external pure returns(address){
        return(approver);
    }

    function withdraw(address payable _receiver) external {
        require(msg.sender == approver);
        receiver = _receiver;
        receiver.transfer(address(this).balance);
    }
}
