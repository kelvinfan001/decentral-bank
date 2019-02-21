const PiggyBankContract = artifacts.require('../../contracts/PiggyBank.sol');

contract('PiggyBankContract', function (accounts) {
    it('initiates contracts', async function(){
        const contract = await PiggyBankContract.deployed();
        const approver = await contract.approver.call();
        assert.equal(approver, 0xF361d9B30A24EC2f1285C6D0F78C262b32B69C40, "approvers don't match");
    });

    it('takes a deposit', async function(){
        var accounts = await web3.eth.getAccounts();
        let contract = await PiggyBankContract.deployed();
        await contract.deposit(accounts[0], { value: 1, from: accounts[0] });
        let balance = await web3.eth.getBalance(contract.address);
        assert.equal(balance.valueOf(), 1, "amounts did not match");
    });
});