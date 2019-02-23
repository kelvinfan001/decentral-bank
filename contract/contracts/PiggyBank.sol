pragma solidity ^0.5.0;

contract PiggyBankFactory {
    address[] public deployedPiggyBanks;

    function createPiggyBank(uint _goal) public {
        PiggyBank newPiggyBank = new PiggyBank(_goal);

        deployedPiggyBanks.push(address(newPiggyBank));
    }

    function getDeployedPiggyBanks() public view returns(address[] memory){
        return deployedPiggyBanks;
    }
}

contract PiggyBank {

    address payable public receiver;
    address public owner;

    uint public goal;

    constructor(uint _goal) public {
        owner = msg.sender;
        goal = _goal;
    }

    function deposit() external payable {
        require(msg.value > 0, "You cannot deposit 0.");
    }

    function viewOwner() external view returns(address){
        return(owner);
    }

    function withdraw(address payable _receiver) external {
        require(msg.sender == owner, "Sender is not the owner of this piggy bank.");
        require(address(this).balance >= goal, "You have not reached your goal yet.");
        receiver = _receiver;
        receiver.transfer(address(this).balance);
    }
}
