pragma solidity ^0.5.0;

contract PiggyBank {

    address public sender;
    address payable public receiver;
    address public constant approver = 0x925834f2ae02AE2a0a659904678ef457fb00BaB2;

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
