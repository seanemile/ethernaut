// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {Telephone} from "../src/Telephone.sol";

contract TelephoneTest is Test {
    Telephone public telephone;
    address public owner = makeAddr("Owner");
    address public attacker = makeAddr("attacker");

    function setUp() public {
        startHoax(owner);
        telephone = new Telephone();
    }

    function testChangeOwner() public {
        vm.stopPrank();
        vm.deal(owner, 1 ether);
        vm.deal(attacker, 1 ether);
        vm.prank(attacker, owner);
        telephone.changeOwner(attacker);
        assertEq(telephone.owner(), attacker);
    }
}
