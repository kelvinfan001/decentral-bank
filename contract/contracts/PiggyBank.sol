pragma solidity ^0.5.0;

contract PiggyBank {

    address payable public receiver;
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "You cannot deposit 0.");
    }

    function viewOwner() external view returns(address){
        return(owner);
    }

    function withdraw(address payable _receiver) external {
        require(msg.sender == owner, "Sender is not the owner of this piggy bank.");
        receiver = _receiver;
        receiver.transfer(address(this).balance);
    }
}
