// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

// First Contract: The Reward Token
contract EduRewardToken is ERC20, Ownable(msg.sender) {
    constructor() ERC20("Educational Reward Token", "EDU") {
        // Mint 1,000,000 tokens to the contract deployer
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

// Second Contract: The Main VR/AR Educational Platform
contract EduVRToken is Ownable(msg.sender), ReentrancyGuard, Pausable {
    IERC20 public rewardToken;
    
    struct User {
        uint256 totalTimeSpent;
        uint256 totalEarnings;
        uint256 lastActivityTimestamp;
        bool isRegistered;
    }
    
    struct Course {
        string name;
        uint256 rewardRate; // tokens per hour
        bool isActive;
    }
    
    mapping(address => User) public users;
    mapping(uint256 => Course) public courses;
    uint256 public courseCount;
    
    // Events
    event UserRegistered(address indexed user);
    event ActivityLogged(address indexed user, uint256 courseId, uint256 timeSpent, uint256 reward);
    event CourseAdded(uint256 indexed courseId, string name, uint256 rewardRate);
    event CourseUpdated(uint256 indexed courseId, string name, uint256 rewardRate);
    
    constructor(address _rewardToken) {
        rewardToken = IERC20(_rewardToken);
    }

    function setRewardToken(address _newRewardToken) external onlyOwner {
        rewardToken = IERC20(_newRewardToken);
    }
    
    // User registration
    function registerUser() external {
        require(!users[msg.sender].isRegistered, "User already registered");
        users[msg.sender] = User(0, 0, block.timestamp, true);
        emit UserRegistered(msg.sender);
    }
    
    // Admin functions
    function addCourse(string memory _name, uint256 _rewardRate) external onlyOwner {
        courseCount++;
        courses[courseCount] = Course(_name, _rewardRate, true);
        emit CourseAdded(courseCount, _name, _rewardRate);
    }
    
    function updateCourse(uint256 _courseId, string memory _name, uint256 _rewardRate, bool _isActive) 
        external 
        onlyOwner 
    {
        require(_courseId <= courseCount, "Course does not exist");
        Course storage course = courses[_courseId];
        course.name = _name;
        course.rewardRate = _rewardRate;
        course.isActive = _isActive;
        emit CourseUpdated(_courseId, _name, _rewardRate);
    }
    
    // Core functionality
    function logActivity(uint256 _courseId, uint256 _timeSpentMinutes) 
        external 
        nonReentrant 
        whenNotPaused 
    {
        require(users[msg.sender].isRegistered, "User not registered");
        require(_courseId <= courseCount, "Course does not exist");
        require(courses[_courseId].isActive, "Course is not active");
        
        User storage user = users[msg.sender];
        Course storage course = courses[_courseId];
        
        // Calculate reward
        uint256 timeSpentHours = _timeSpentMinutes / 60;
        uint256 reward = timeSpentHours * course.rewardRate;
        
        // Update user stats
        user.totalTimeSpent += _timeSpentMinutes;
        user.totalEarnings += reward;
        user.lastActivityTimestamp = block.timestamp;
        
        // Transfer rewards
        require(rewardToken.transfer(msg.sender, reward), "Reward transfer failed");
        
        emit ActivityLogged(msg.sender, _courseId, _timeSpentMinutes, reward);
    }
    
    // View functions
    function getUserStats(address _user) 
        external 
        view 
        returns (uint256 totalTime, uint256 totalEarnings) 
    {
        User storage user = users[_user];
        return (user.totalTimeSpent, user.totalEarnings);
    }
    
    // Emergency functions
    function pause() external onlyOwner {
        _pause();
    }
    
    function unpause() external onlyOwner {
        _unpause();
    }
    
    function withdrawTokens(uint256 _amount) external onlyOwner {
        require(rewardToken.transfer(owner(), _amount), "Withdrawal failed");
    }
}