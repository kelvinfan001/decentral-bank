var PiggyBankFactoryContract = artifacts.require("PiggyBankFactory");

module.exports = function(deployer) {
    deployer.deploy(PiggyBankFactoryContract);
};