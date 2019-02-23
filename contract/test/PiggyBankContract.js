const PiggyBankContract = artifacts.require('../../contracts/PiggyBank.sol');

contract('PiggyBankContract', function (accounts) {
    it('initiates contracts', async function(){
        const contract = await PiggyBankContract.deployed();
        const approver = await contract.approver.call();
        assert.equal(approver, 0x107cec7777c0CBA5f9A9AdB0E64696f93Cb45FF8, "approvers don't match");
    });

    it('takes a deposit', async function(){
        var accounts = await web3.eth.getAccounts();
        let contract = await PiggyBankContract.deployed();
        await contract.deposit({ value: 1, from: accounts[0] });
        let balance = await web3.eth.getBalance(contract.address);
        assert.equal(balance.valueOf(), 1, "amounts did not match");
    });

    it('withdraws', async function(){
        var accounts = await web3.eth.getAccounts();
        let contract = await PiggyBankContract.deployed();
        await contract.withdraw(accounts[0], { from: accounts[0]});
        let balance = await web3.eth.getBalance(contract.address);
        assert.equal(balance.valueOf(), 0, "amounts did not match");
    })
});