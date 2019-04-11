pragma solidity ^0.5.0;

contract hackerCoin {
    // VARIABLES
    // name
    // symbol
    // totalSupply
    // balanceOf
    // owner
    string public name = 'Hacker Garage Coin';
    string public symbol = 'HGC';
    uint256 totalSupply;
    mapping(address => uint256) public balanceOf;
    address owner;
    mapping(address => mapping(address => uint256)) public allowance;
    
    // 0x1111
    // BAM : [
    //    {
    //        Arath: '50', 0x2111
    //    },
    //    Nacho: '20',
      //  Anthony: '10'
    //
    
    // EVENTS
    // Transfer
    // Approval
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    
    // constructor 
    constructor(uint256 _initialSupply) public {
        totalSupply = _initialSupply;
        owner = msg.sender;
        balanceOf[owner] = totalSupply;
    }
    
    // METHODS
    
    function transfer(address _to,  uint256 _value) public returns(bool) {
        // Balance of the account executing the transaction is greater or equal than the amount being sending
        require(_value <= balanceOf[msg.sender]);
        
        balanceOf[msg.sender] -=  _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    // 0x692a70d2e424a56d2c6c27aa97d1a86395877b3a
    // Blockchain Academy $500000000
    // Arath => Payment to Nacho
    // Arath (BAM) => nacho
    // BAM => Authorize Arath to use the available funds
    
     function approve(address _spender, uint256 _value) public returns (bool){
        allowance[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);
        
        return true;
    }
    
 function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    // Anthony has enough funds to send Nacho
    require(_value <= balanceOf[_from]);
    
    // Arath has authorization to transfer the funds
    require(_value <= allowance[_from][msg.sender]);
    
    require(msg.sender != _to);
    
    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;
    
    emit Transfer(_from, _to, _value);
    return true;
}
    // transfer 
    // transferFrom
    // approve
    // allowance 
}

// 0x692a70d2e424a56d2c6c27aa97d1a86395877b3a
// Lo que pasa en el blockchain se queda en el blockchain
// 0xbbf289d846208c16edc8474705c748aff07732db