// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract SimpleStorage {
    uint256 MyfavoriteNumber;
    //uint[] listofNumbers;

    struct Person{
        uint favoriteNumber;
        string name;
    }

    //Se puede limitat tamaño!
    Person[] public listofPeople;

    //Creeamos maping
    mapping(string => uint) public nameToFavNumber;

    function store(uint256 _favoriteNumber) public{
        MyfavoriteNumber = _favoriteNumber;    
    }

    //View, pure
    //Llamar a un view o aun pure desde una funcion con gas, CONSUME GAS !
    function retrieve() public view returns (uint){
        return MyfavoriteNumber;
    }

    // calldata and Memory temporal, storage permanente (fuera de la funcion)
    // Call data no puede modificarse
    // Memory si puede modificarse
    function addPerson (string memory _name, uint _favoriteNumber) public {
        listofPeople.push(Person(_favoriteNumber, _name));

        //Mapeamos
        nameToFavNumber[_name] = _favoriteNumber;

    }

}

