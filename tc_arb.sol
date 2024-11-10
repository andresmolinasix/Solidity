// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract tc_arb {

    address payable public owner;

    struct Data {
                    string date;
                    string delivery_date;
                    string product;
                    string price;
                    string code;
                    string cel_number;
                    int8 status; 
                    address wallet; }
    
    Data public data;

    event newData(
                    string date,
                    string delivery_data,
                    string product,
                    string price,
                    string code,
                    string cel_number,
                    int8   status,
                    address wallet);

    modifier onlyOwner(){
        require(msg.sender == owner, "Solo el propietario puede retirar los fondos");
        _;
    } 

    modifier cost(uint amount){
        require(msg.value >= amount, "No tiene saldo en ARB para ejecutar");
        _;
    }

    constructor (){
        owner = payable (msg.sender);
    }

    function pushData(
                    string memory _date,
                    string memory _delivery_date,
                    string memory _product,
                    string memory _price,
                    string memory _code,
                    string memory _cel_number,
                    int8 _status) public payable  cost(1000000000000000){

        data = Data(_date,
                    _delivery_date,
                    _product,
                    _price,
                    _code,
                    _cel_number,
                    _status,
                    msg.sender);

        emit newData(_date,
                    _delivery_date,
                    _product,
                    _price,
                    _code,
                    _cel_number,
                    _status,
                    msg.sender);
        }

            function withdraw() public onlyOwner {
                uint balance = address(this).balance;
                require(balance > 0, "No se tiene fondos en el contrato todavia");
                owner.transfer(balance);
            }

        function getBalance() public view returns (uint256){
            return address(this).balance;
        }


}