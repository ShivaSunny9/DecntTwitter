pragma solidity ^0.5.3;

contract tweetBook {
    
    struct account{
        string name;
        address addr;
        string bio;
        string location;
        string[] tweets;
        bool isCreated;
          }
    struct tweets {
        string content;
        address writtenBy;
        uint timestamp;
        bool isTweeted;
           }
    struct Message {
        string content;
        address writtenBy;
        uint256 timestamp;
           }
    tweets[] public  allTweets;
    
    
    mapping (address=> account) public userAccounts;
    mapping (string=> tweets) userTweets;
    mapping(address => Message[]) private userMessages;
    
  // adding account
    
    function createAccount(string memory _name, string memory _location, string memory _bio) public {
        require(!userAccounts[msg.sender].isCreated);
        
        userAccounts[msg.sender].name =_name;
        userAccounts[msg.sender].addr = msg.sender;
        userAccounts[msg.sender].location =_location;
        userAccounts[msg.sender].bio =_bio;
        userAccounts[msg.sender].isCreated = true;
                      }
                
    //updating credentials
    function updateCredentials(string memory _name, string memory _location, string memory _bio) public {
        require(userAccounts[msg.sender].isCreated);
        
        userAccounts[msg.sender].name =_name;
        userAccounts[msg.sender].location =_location;
        userAccounts[msg.sender].bio =_bio;
                }
                
    //adding tweet
    function addTweet(string memory _title, string memory _content) public {
         require(userAccounts[msg.sender].isCreated);
         require(!userTweets[_title].isTweeted);
         
         tweets memory Tweet = tweets(_content, msg.sender, now, true);
          userTweets[_title].content = _content;
          userTweets[_title].writtenBy = msg.sender;
          userTweets[_title].timestamp = now;
          userTweets[_title].isTweeted = true;
          allTweets.push(Tweet);
          userAccounts[msg.sender].tweets.push(_title);
                }
                
         //delete tweet
         function deleteTweet(string memory _title)  public {
             require(userTweets[_title].writtenBy ==msg.sender);
             
             delete userTweets[_title];
               }
               
         // send message
         function writeMessage(address to, string memory _content) public {
             require(userAccounts[msg.sender].isCreated);
             require(userAccounts[to].isCreated);
             
            Message memory message = Message(_content, msg.sender, now);
           userMessages[to].push(message);
          }

        
    //your account return section
    function myAccount() public view returns(string memory, address, string memory, string memory) {
        return (userAccounts[msg.sender].name, userAccounts[msg.sender].addr, userAccounts[msg.sender].bio, userAccounts[msg.sender].location);
    }
   
    //getting messages 
    
    function getMessages(uint256 index) public view returns(string memory, address, uint) {
        return (userMessages[msg.sender][index].content, userMessages[msg.sender][index].writtenBy, userMessages[msg.sender][index].timestamp);
            }
    function getMessagesLength() public view returns(uint) {
        return userMessages[msg.sender].length;
            }
    function getTweetsLength() public view returns(uint) {
        return allTweets.length;
            }
    //tweets  return section
    
     function searchTweets(string memory _title) public view returns(address,string memory, uint) {
        return (userTweets[_title].writtenBy, userTweets[_title].content, userTweets[_title].timestamp);
            }
 
}