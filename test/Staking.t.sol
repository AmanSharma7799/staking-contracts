// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Staking} from "../src/Staking.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor() ERC20("TestToken", "TT") {
        _mint(msg.sender, 1_000_000 ether);
    }
}

contract CounterTest is Test {
    Staking public staking;
    Token public stakingToken;
    Token public rewardToken;
    address user = address(1);

    function setUp() public {
        stakingToken = new Token();
        rewardToken = new Token();

        staking = new Staking(address(stakingToken), address(rewardToken));
        stakingToken.transfer(user, 1000 ether);
        rewardToken.transfer(address(staking), 1000 ether);
    }

    function testStakeAndEarn() public {
        vm.startPrank(user);
        stakingToken.approve(address(staking), 100 ether);
        staking.stake(100 ether);
        vm.warp(block.timestamp + 100); // simulate 100 seconds
        staking.claimReward();
        vm.stopPrank();
    }
}
