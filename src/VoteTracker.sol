// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract VoteTracker {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    uint public candidatesCount;

    mapping(uint => Candidate) public candidates;

    mapping(address => bool) public hasVoted;

    event VoteCast(uint indexed candidateId);

    modifier hasNotVoted() {
        require(!hasVoted[msg.sender], "You have already voted.");
        _;
    }

    function addCandidate(string memory name) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
    }

    function getCandidate(
        uint _candidateId
    ) public view returns (Candidate memory) {
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid candidate."
        );
        return candidates[_candidateId];
    }

    function deleteCandidate(uint _candidateId) public {
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid candidate."
        );
        delete candidates[_candidateId];
    }

    function getCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory candidateList = new Candidate[](candidatesCount);
        for (uint i = 1; i <= candidatesCount; i++) {
            candidateList[i - 1] = candidates[i];
        }
        return candidateList;
    }

    function vote(uint _candidateId) public hasNotVoted {
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid candidate."
        );

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;

        emit VoteCast(_candidateId);
    }
}
