// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

struct Stakepage {
    uint256 amount;
    uint256 timestamp;
}

mapping (address => Stakepage[])stakeBook;


contract Staking {
    event Staking(address indexed _staker, uint256 _amount);

    function stake(uint256 _amount) public payable {
        Stakepage[] stakepages = stakeBook[msg.sender];
        if (stakepages.length == 0) {
            stakepages.push(Stakepage({amount: _amount, timestamp: block.timestamp}));
        } else {
            stakepages[0].amount += _amount;
            stakepages[0].timestamp = block.timestamp;
        }
        stakeBook[msg.sender] = stakepages;
        emit Staking(msg.sender, _amount);
    }

    function unstake(uint256 _amount) public {
        require(_amount <= balance);
        Staking(msg.sender, -_amount);
    }
}
