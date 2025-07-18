const DiaryDapp = artifacts.require("DiaryDapp");
const HelloWorld = artifacts.require("HelloWorld");
const Counter = artifacts.require("Counter");

module.exports = function (deployer) {
  deployer.deploy(DiaryDapp);
  deployer.deploy(HelloWorld, "Hello, World!");
    deployer.deploy(Counter);
};