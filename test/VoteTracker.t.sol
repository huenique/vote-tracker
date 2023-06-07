// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/VoteTracker.sol";

contract CounterTest is Test {
    VoteTracker public tracker;

    function setUp() public {
        tracker = new VoteTracker();
    }

    function testVote() public {
        tracker.addCandidate("Alice");

        uint candidateId = 1;

        tracker.vote(candidateId);

        uint voteCount = tracker.getCandidate(candidateId).voteCount;

        assertEq(voteCount, 1);
        assertTrue(tracker.hasVoted(address(this)));
    }

    function testHasNotVoted() public {
        assertTrue(!tracker.hasVoted(address(this)));
    }

    function testAddCandidates() public {
        tracker.addCandidate("Alice");
        tracker.addCandidate("Bob");

        assertEq(tracker.candidatesCount(), 2);
    }
}
