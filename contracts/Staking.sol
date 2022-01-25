// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

//importing IERC20 interface for safetransfer
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Staking is ReentrancyGuard {
    using SafeERC20 for IERC20;
    address tokenaddress;

    //Staking contract constructor
    constructor(address _tokenaddress) {
        tokenaddress = _tokenaddress;
    }

    event Stake(address indexed _staker, uint256 _amount);
    event Unstake(address indexed _staker, uint256 _amount);

    mapping(address => Stakepage[]) stakeBook;
    struct Stakepage {
        uint256 amount;
        uint256 timestamp;
    }

    function stake(uint256 _amount) public {
        Stakepage[] storage stakepages = stakeBook[msg.sender];
        require(
            stakepages.length <= 5,
            "You can only have 5 stakes , please unstake some"
        );
        stakepages.push(
            Stakepage({amount: _amount, timestamp: block.timestamp})
        );
        //transfer the amount to the staking contract
        IERC20(tokenaddress).safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );
        emit Stake(msg.sender, _amount);
    }

    function viewUnstakeAmount() public view returns (uint256) {
        Stakepage[] memory stakepages = stakeBook[msg.sender];
        uint256 available_unstakeAmount;
        require(stakepages.length != 0, "No staking to unstake");
        for (uint256 i = 0; i < stakepages.length; i++) {
            available_unstakeAmount += intrestCalc(
                stakepages[i].amount,
                stakepages[i].timestamp
            );
        }
        return available_unstakeAmount;
    }

    // Function to calculate intrest earned on staked tokens
    function intrestCalc(uint256 totalStaked, uint256 timestamp)
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
            interest = ((totalStaked * 15) / 100); // 15% intrest if 12 weeks to 24 weeks
        } else if (totalTime > 24 weeks && totalTime < 36 weeks) {
            interest = ((totalStaked * 30) / 100); // 30% intrest if 24 weeks to 36 weeks
        } else if (totalTime > 36 weeks) {
            interest = ((totalStaked * 45) / 100); // 45% intrest if 36 weeks or more
        }
        uint256 unstakeAmount = interest + totalStaked; // add total staked tokens to intrest
        return unstakeAmount;
    }

    function unStake() external nonReentrant {
        Stakepage[] memory stakepages = stakeBook[msg.sender];
        uint256 available_unstakeAmount;
        require(stakepages.length != 0, "No staking to unstake");
        available_unstakeAmount = viewUnstakeAmount();
        require(available_unstakeAmount > 0, "No staking to unstake");
        // transfer tokens to staker from staking contract
        IERC20(tokenaddress).safeTransfer(msg.sender, available_unstakeAmount);
        emit Unstake(msg.sender, available_unstakeAmount);
    }
}
