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

    // Function to calculate intrest earned on staked tokens
    function intrestcalc(uint256 totalStaked, uint256 timestamp)
        private
        view
        returns (uint256)
    {
        uint256 interest = 0;
        uint256 totalTime = block.timestamp - timestamp; // time difference to know time passed since last stake tokens staked
        if (totalTime < 12 weeks) {
            interest = 0; // intrest is 0 if less than 12 weeks
        }
        if (totalTime > 12 weeks && totalTime < 24 weeks) {
            interest = (totalStaked / 15) * 100; // 15% intrest if 12 weeks to 24 weeks
        } else if (totalTime > 24 weeks && totalTime < 36 weeks) {
            interest = (totalStaked / 30) * 100; // 30% intrest if 24 weeks to 36 weeks
        } else if (totalTime > 36 weeks) {
            interest = (totalStaked / 45) * 100; // 45% intrest if 36 weeks or more
        }
        return interest;
    }

    function unstake() public {
        Stakepage[] memory stakepages = stakeBook[msg.sender];
        uint256 available_unstakeAmount;
        require(stakepages.length != 0, "No staking to unstake");
        for (uint256 i = 0; i < stakepages.length; i++) {
            available_unstakeAmount =
                stakepages[i].amount +
                available_unstakeAmount;
        }
        emit Unstake(msg.sender, available_unstakeAmount);
    }
}
