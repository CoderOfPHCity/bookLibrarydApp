// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Bookshop {

    Book[] public books; 

    address public librarian;

    constructor () {
        librarian = msg.sender;
    }

    struct Book  {
        uint id;
        string bookName;
        string authorName;
        uint price;
        uint bPrice;
        BookCategory category;
    }

    mapping (address => uint) balances;
    mapping (uint => address[]) buyers;
    

    enum BookCategory {
        fiction, nonFiction
    }

    modifier onlyLibrarian () {
        require(librarian == msg.sender, "comot for here");
        _;
    }

    function purchaseBook(uint _id, uint amount) public{
      
        require(books[_id].id == _id, "This book is not available");
        require(books[_id].price > amount, "insufficient balance");
        balances[msg.sender] -= amount;

        buyers[_id].push(msg.sender);
    }

    function addBook(
        string memory _bookName, 
        string memory _authorName, 
        uint _price,
        uint _bPrice,
        uint _id,
        BookCategory  _category) public onlyLibrarian {

            Book memory newBook = Book({
                bookName: _bookName,
                authorName: _authorName,
                price: _price,
                bPrice: _bPrice,
                id: _id,
                category: _category
                
            });
   

   
books.push(newBook);
    }

function getAllBooks() public onlyLibrarian view returns (Book[] memory) {
    
        return books;
    
}


}