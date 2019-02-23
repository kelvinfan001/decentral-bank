pragma solidity ^0.5.0;

//contract PiggyBankFactory {
//    mapping(address => PiggyBank) public existingPiggyBanks;
//
//    address[] public deployedPiggyBanks;
//
//    function createPiggyBank(uint _goal) public {
//        PiggyBank newPiggyBank = new PiggyBank(_goal);
//
//        existingPiggyBanks[address(msg.sender)] = newPiggyBank;
//    }
//
//    function deposit(address _to) public {
//        require(existingPiggyBanks[_to].goal() > 0); // requires _to to have a piggy bank.
//        existingPiggyBanks[_to].deposit();
//    }
//}

contract PiggyBank {

    mapping(address => uint256) public accountsToGoals;
    mapping(address => uint256) public accountsToBalances;

    function createPiggyBank(uint256 _goal) public {
        require(_goal > 0);
        accountsToBalances[msg.sender] = 0;
        accountsToGoals[msg.sender] = _goal;
    }


    function deposit() external payable {
        require(msg.value > 0, "You cannot deposit 0.");
        require(accountsToGoals[msg.sender] != 0);
        accountsToBalances[msg.sender] += msg.value;
    }

    function withdraw(address payable _receiver) external {
        uint256 goal = accountsToGoals[msg.sender];
        uint256 balance = accountsToBalances[msg.sender];

        require(balance >= goal, "You have not reached your goal yet.");
        _receiver.transfer(balance);
    }
}
