// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract Twitter{


//add struck
     
     uint16 public  MAX_TWEET_LENGTH=280;

     struct Tweet{
          uint256 id;
          address author;
          string  content;
          uint256 timestamp;
          uint256 likes;
     }


    // add Function

   mapping (address => Tweet[]) public tweets;
     address public  owner;

   constructor(){
     owner=msg.sender;
   }

   modifier onlyOwner(){
     require(msg.sender == owner,"YOU ARE NOT THE OWNER!");
     _;
   }

     function changeTweetLeangth(uint16 newTweetLangth)public onlyOwner {
          MAX_TWEET_LENGTH=newTweetLangth;
     }


   function createTweet(string memory _tweet) public {

     require(bytes (_tweet).length <= MAX_TWEET_LENGTH,"Tweet is so long bro! ");

     Tweet memory newTweet=Tweet({
          id:tweets[msg.sender].length,
          author: msg.sender,
          content:_tweet,
          timestamp:block.timestamp,
          likes:0
     });

     tweets[msg.sender].push(newTweet);
    
   }

   function liketweet(address author,uint256 id)external  {
    require(tweets[author][id].id==id,"TWEET DOSE NOT EXITE!");
    
     tweets[author][id].likes++;
   }

   function unlikeTweet(address author,uint256 id) external {
    require(tweets[author][id].id==id,"TWEET DOES NOT EXITE!");
    require(tweets[author][id].likes>0,"TWEET HAS NO LIKE!");
     tweets[author][id].likes--;
   }

   function getTweet(address _woner, uint _i) public view  returns (Tweet memory) {
                return tweets[_woner][_i];

   }

   function gelAllTweet(address _woner) public  view returns (Tweet[] memory){
          return tweets[_woner];
   }

}

