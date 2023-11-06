// Raffle

// Enter the lottery (paying some amount)
// Pick a random winner (verifiably random)

// Winner to be selected every X minutes -> completely automated

// ChainlinkOracle -> Randomness, Automated execution

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import "node_modules\@chainlink\contracts\src\v0.8\interfaces\VRFCoordinatorV2Interface.sol"

error Raffle__NotEnoughEthEntered();

contract Raffle is VRFConsumerBaseV2 {
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;

    event RaffleEnter(address indexed player);

    constructor(address vrfCoordinatorV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_entranceFee = entranceFee;
        vrfCoordinator=VRFCoordinatorV2Interface(vrfCoordinatorV2);
    }

    function enterRaffle() public payable {
        // require (msg.value > i_entranceFee, "Not enough ETH!")
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthEntered();
        }
        s_players.push(payable(msg.sender));
        // Events
        // Whenever we update a dynamic array or map we wnt to emit an event
        // Logging and events
        // Viewing Events
        // Events in Hardhat

        // Logs and events are often used synonymously
        // Smart contract can't access logs
        emit RaffleEnter(msg.sender);
    }

    function requestRandomWinner() external {
        // Request the random number
        // Once we get it do something with it
        // 2 transaction process
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {}

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }
}
