// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/Token.sol";

contract TokenTest is Test {
    Token public token;
    address public owner = makeAddr("Owner");
    address public random = makeAddr("Random");

    function setUp() public {
        vm.deal(owner, 1 ether);
        vm.startPrank(owner);
        token = new Token(20);
    }

    function testTransfer() public {
        bool sucess = token.transfer(random, 21);
        assertTrue(sucess);
        emit log_uint(token.balances(owner));
    }
}
