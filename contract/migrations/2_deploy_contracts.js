var PiggyBankContract = artifacts.require("./PiggyBank.sol");

module.exports = function(deployer) {
    deployer.deploy(PiggyBankContract);
};