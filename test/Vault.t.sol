// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;

    function setUp() public {
        vault = new Vault(bytes32("password"));
    }

    function testUnlock() public {
        vault.unlock(bytes32("password"));
        assertTrue(!vault.locked());
    }
}
