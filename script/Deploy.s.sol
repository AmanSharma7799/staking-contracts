// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Staking} from "../src/Staking.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockToken is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 1_000_000 ether);
    }
}

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        MockToken stakingToken = new MockToken("StakingToken", "STK");
        console.log("Staking Token Address:", address(stakingToken));

        MockToken rewardToken = new MockToken("RewardToken", "RWD");
        console.log("Reward Token Address:", address(rewardToken));

        Staking stakingContract = new Staking(
            address(stakingToken),
            address(rewardToken)
        );
        console.log("Staking Contract Address:", address(stakingContract));

        rewardToken.transfer(address(stakingContract), 500_000 ether);

        vm.stopBroadcast();
    }
}
