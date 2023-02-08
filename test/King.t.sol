// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {King} from "../src/King.sol";

contract KingTest is Test {
    King public king;
    address public owner = makeAddr("owner");
    address public attacker = makeAddr("attacker");

    function setUp() public {
        king = new King{value: 1 ether}();
    }

    function testKing() public {
        vm.expectRevert("King forever");
        (bool sucess, ) = payable(address(king)).call{value: 10 ether}("");
        sucess;
    }

    receive() external payable {
        revert("King forever");
    }
}
