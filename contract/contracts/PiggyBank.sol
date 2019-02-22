pragma solidity ^0.5.0;

contract PiggyBank {

    address public sender;
    address payable public receiver;
    address public constant approver = 0xF361d9B30A24EC2f1285C6D0F78C262b32B69C40;

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
