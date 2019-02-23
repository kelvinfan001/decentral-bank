const PiggyBankContract = artifacts.require('../../contracts/PiggyBank.sol');


contract('PiggyBankContract', function () {
    it('initiates contracts', async function(){
        const accounts = await web3.eth.getAccounts();
        const contract = await PiggyBankContract.new(1, {from: accounts[1]});
        const owner = await contract.owner.call();
        assert.equal(owner, accounts[1], "owners don't match");
    });

    it('takes a deposit', async function(){
        const accounts = await web3.eth.getAccounts();
        let contract = await PiggyBankContract.new(1, {from: accounts[0]});
        await contract.deposit({ value: 1, from: accounts[0] });
        let balance = await web3.eth.getBalance(contract.address);
        assert.equal(balance.valueOf(), 1, "amounts did not match");
    });

    it('tries to withdraw without permission', async function(){
        const accounts = await web3.eth.getAccounts();
        let contract = await PiggyBankContract.new(1, {from: accounts[1]});
        await contract.deposit({value: 1, from: accounts[1]});

        try {
            await contract.withdraw(accounts[0], { from: accounts[0]});
        } catch (error) {
            err = error;
        }
        assert.ok(err instanceof Error, "should not have had permission to withdraw");
    })

    it('withdraws after reaching goal', async function(){
        const accounts = await web3.eth.getAccounts();
        let contract = await PiggyBankContract.new(10, {from: accounts[1]});
        await contract.deposit({value: 10, from: accounts[1]});

        await contract.withdraw(accounts[1], { from: accounts[1]});

        let balance = await web3.eth.getBalance(contract.address);
        assert.equal(balance.valueOf(), 0, "amounts did not match");
    })

    it('withdraws before reaching goal', async function(){
        const accounts = await web3.eth.getAccounts();
        let contract = await PiggyBankContract.new(10, {from: accounts[1]});
        await contract.deposit({value: 5, from: accounts[1]});

        try {
            await contract.withdraw(accounts[1], { from: accounts[1]});
        } catch (error) {
            err = error;
        }
        assert.ok(err instanceof Error, "error should have occurred when trying to withdraw before reaching goal.");
    })
});