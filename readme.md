
## Project Title
EduVR - Educational VR/AR Token Rewards Platform

## Project Description
EduVR is a decentralized educational platform designed for Virtual Reality (VR) and Augmented Reality (AR) environments. The platform allows users to earn Educational Reward Tokens (EDU) by engaging with educational content in the form of VR/AR courses. By participating in various courses, users can accumulate tokens based on the time spent on each course, with each course having its own reward rate. 

The project consists of two smart contracts:
1. **EduRewardToken**: The ERC-20 token contract that issues reward tokens (EDU).
2. **EduVRToken**: The platform contract that manages course content, user registrations, and activity logging, allowing users to earn EDU tokens.

The system is powered by Ethereum-based smart contracts, ensuring transparency, security, and fairness in distributing educational rewards.

## Contract Address
0x441Fb56d60a9712e9F78e44aeC52b6543b8834EE
![image](https://github.com/user-attachments/assets/0c8e907a-eae1-46e6-b811-fb5694cc69de)

## Key Features

- **Educational Rewards**: Users can earn EDU tokens by spending time on courses in VR/AR, with reward rates tied to each course's duration and complexity.
  
- **ERC-20 Token Integration**: The `EduRewardToken` is a standard ERC-20 token used to reward users based on their activity within the platform.

- **User Registration & Activity Tracking**: Users can register on the platform and track their activity, including total time spent and earnings.

- **Course Management by Admin**: The platform allows the owner to add, update, and deactivate courses with different reward rates. 

- **Time-based Rewards**: Reward tokens are calculated based on the time spent in each course, ensuring users are rewarded according to their engagement.

- **Security Features**: Integrated with OpenZeppelin contracts for security (Pausable, ReentrancyGuard, and Ownable), ensuring safe contract interactions and flexibility for pausing and withdrawing funds if necessary.

- **Emergency Pause/Unpause**: The owner can pause and resume the contract operations in case of emergencies or updates.

- **Decentralized & Transparent**: Built on Ethereum blockchain, ensuring the integrity of all transactions, activity logs, and rewards distribution is transparent and verifiable.

---








### Notes:
- **Contract Address**: After deploying the contracts, you will need to update the contract addresses in the README file.
- **Installation & Setup**: This section assumes you're using Hardhat for deploying the contracts. If you're using a different framework like Truffle, modify the instructions accordingly.
- **Project Features**: These describe the core functionalities of the smart contracts and how they interact with users and admins.

This README file gives a comprehensive overview of your project, outlining its purpose, key features, installation instructions, and potential contribution guidelines.
