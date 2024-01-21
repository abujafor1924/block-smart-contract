
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract PausableToken{

    address public owner;
    bool public paused;
    mapping (address => uint) public  ballance;

    constructor(){
        owner=msg.sender;
        paused=false;
        ballance[owner]=1000;

    }

    modifier onlyOwner(){

        require(msg.sender==owner,"YOU ARE NOT THE OWNER!");
        _;
    }
    modifier notPaused(){
        require(paused==false,"THE CONTRACT IS PAUSEED!");
        _;
    }

    function pause()public onlyOwner{
        paused=true;
    }
    function unpause()public onlyOwner{
        paused=false;
    }

    

    function transfer(address to,uint amount )public notPaused {
        require(ballance[msg.sender]>=amount,"Insuffecient Balance");
        ballance[msg.sender]-=amount;
        ballance[to]+=amount;
    }

}