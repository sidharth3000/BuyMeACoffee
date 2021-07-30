pragma solidity ^0.4.17;


contract CharityFactory {
    address[] public deployedCharity;

    function createCharity(string ttl, string desc,bool targeted,uint trgt) public {
        address newCharity = new Charity(msg.sender, ttl, desc, targeted, trgt);
        deployedCharity.push(newCharity);
    }

    function getDeployedCharity() public view returns (address[]) {
        return deployedCharity;
    }
}

contract Charity {
    
    struct Contribution{
        address adrs;
        string name;
        uint amount;
        // time;
    }
    
    Contribution[] public contributions;
    
    address public manager;
    string public title;
    string public description;
    
    mapping(address => bool) public contributors;
    uint public contributorsCount;
    
    bool public targeted;
    uint public target;
    
    constructor (address mngr,string ttl, string desc,bool targeted,uint trgt) public{
        
        manager = mngr;
        title = ttl;
        description = desc;
        targeted = targeted;
        
        if(targeted)
        target = trgt;
        else
        target=0;
    }
    
    function contribute(string nme) payable public{
        
        Contribution memory newContri = Contribution({
            adrs: msg.sender,
            name: nme,
            amount: msg.value
        });
        
        
        contributions.push(newContri);
        
    }
    
    function getSummary() view returns(address, string, string, uint, bool, uint) {
        return(
            manager,
            title,
            description,
            this.balance,
            targeted,
            target
            );
    }
    
}