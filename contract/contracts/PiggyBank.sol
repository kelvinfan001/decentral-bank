pragma solidity ^0.5.0;

/** @title Piggy Bank. */
contract PiggyBank {

    mapping(address => uint256) public accountsToGoals;
    mapping(address => uint256) public accountsToBalances;

    /** @dev Creates a new piggy bank with a goal that must be reached before being able to withdraw.
      * @param _goal Goal to be reached before being allowed to withdraw.
      */
    function createPiggyBank(uint256 _goal) public {
        require(_goal > 0, "Your goal must be greater than 0."); // make sure that specified goal is greater than 0.
        accountsToBalances[msg.sender] = 0;
        accountsToGoals[msg.sender] = _goal;
    }

    /** @dev Deposits into sender's piggy bank, if it exists.
      */
    function deposit() external payable {
        require(msg.value > 0, "You cannot deposit 0."); // make sure that user is depositing more than 0.
        require(accountsToGoals[msg.sender] != 0);
        accountsToBalances[msg.sender] += msg.value;
    }

    /** @dev Withdraws from sender's piggy bank and deposits that into a specified account.
      * @param _receiver The account to deposit the withdrew money into.
      */
    function withdraw(address payable _receiver) external {
        uint256 goal = accountsToGoals[msg.sender];
        uint256 balance = accountsToBalances[msg.sender];

        require(balance >= goal, "You have not reached your goal yet."); // make sure that the goal has been reached.
        _receiver.transfer(balance);
    }
}
