// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Staking {
    event Stake(address indexed _staker, uint256 _amount);
    event Unstake(address indexed _staker, uint256 _amount);

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
        emit Stake(msg.sender, _amount);
    }

    function intrestcalc() {
        Stakepage[] storage stakepages = stakeBook[msg.sender];
        if (stakepages.length == 0) {
            return;
        }
        uint256 totalStaked = stakepages[i].amount;
        uint256 totalTime = block.timestamp - stakepages[i].timestamp;
        if (totalTime > 12 weeks && totalTime < 24 weeks) {
            uint256 interest = totalStaked * totalTime;
            msg.sender.transfer(interest);
        }
        uint256 intrest = (totalStaked / 15) * 100;
        msg.sender.transfer(intrest);
    }

    function unstake(uint256 _amount) public {
        Stakepage[] memory stakepages = stakeBook[msg.sender];
        uint256 available_unstakeAmount;
        require(stakepages.length != 0, "No staking to unstake");
        for (uint256 i = 0; i < stakepages.length; i++) {
            available_unstakeAmount =
                stakepages[i].amount +
                available_unstakeAmount;
        }
        require(
            _amount < available_unstakeAmount,
            "Not enough staked to unstake"
        );
        emit Unstake(msg.sender, _amount);
    }
}
