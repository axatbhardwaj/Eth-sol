// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Staking {
    event Staking(address indexed _staker, uint256 _amount);

    mapping(address => Stakepage[]) stakeBook;

    struct Stakepage {
        uint256 amount;
        uint256 timestamp;
    }

    function stake(uint256 _amount) public payable {
        Stakepage[] storage stakepages = stakeBook[msg.sender];
        if (stakepages.length == 0) {
            stakepages.push(
                Stakepage({amount: _amount, timestamp: block.timestamp})
            );
        } else {
            stakepages[0].amount += _amount;
            stakepages[0].timestamp = block.timestamp;
        }
        stakeBook[msg.sender] = stakepages;
        emit Staking(msg.sender, _amount);
    }

    function unstake(uint256 _amount) public {
        Stakepage[] memory stakepages = stakeBook[msg.sender];
        require(stakepages.length != 0, "No staking to unstake");
        require(stakepages[0].amount < _amount, "Not enough staked to unstake");
        stakepages[0].amount -= _amount;
        stakeBook[msg.sender] = stakepages;
    }
}
