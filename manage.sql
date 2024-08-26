-- Creating Tables

-- Library Table
CREATE TABLE Library(
    LibraryID VARCHAR(255) NOT NULL, 
    LibraryName VARCHAR(255), 
    LibraryAddress VARCHAR(255), 
    LibraryEmail VARCHAR(255), 
    LibraryBookCount INT, 
    PRIMARY KEY(LibraryID)
);

INSERT INTO Library VALUES('lib101','Central Library','New York','central_lib@gmail.com',3000);
INSERT INTO Library VALUES('lib102','Community Library','Boston','community_lib@gmail.com',1500);

-- Author Table
CREATE TABLE Author(
    AuthorID VARCHAR(255) NOT NULL, 
    AuthorName VARCHAR(255), 
    AuthorEmail VARCHAR(255), 
    AuthorNationality VARCHAR(255), 
    PRIMARY KEY(AuthorID)
);

INSERT INTO Author VALUES('auth100','John Doe','john_doe@gmail.com','American');
INSERT INTO Author VALUES('auth101','Jane Smith','jane_smith@gmail.com','British');

-- Book Table
CREATE TABLE Book(
    BookID VARCHAR(255) NOT NULL, 
    BookTitle VARCHAR(255), 
    BookGenre VARCHAR(255), 
    BookPublishedYear INT, 
    AuthorID VARCHAR(255), 
    PRIMARY KEY(BookID), 
    FOREIGN KEY(AuthorID) REFERENCES Author(AuthorID)
);

INSERT INTO Book VALUES('bk100','Learning SQL','Technology',2020,'auth100');
INSERT INTO Book VALUES('bk101','Mastering Python','Technology',2018,'auth101');

-- LibraryBookRelation Table
CREATE TABLE LibraryBookRelation(
    LibraryID VARCHAR(255), 
    BookID VARCHAR(255), 
    FOREIGN KEY(LibraryID) REFERENCES Library(LibraryID), 
    FOREIGN KEY(BookID) REFERENCES Book(BookID), 
    PRIMARY KEY(LibraryID, BookID)
);

INSERT INTO LibraryBookRelation VALUES('lib101','bk100');
INSERT INTO LibraryBookRelation VALUES('lib102','bk101');

-- PL/SQL Scripts

-- Display Book Details in a Specific Library
DECLARE 
    CURSOR c1 IS 
        SELECT b.BookID, b.BookTitle, b.BookGenre, b.BookPublishedYear, a.AuthorName 
        FROM Book b 
        JOIN LibraryBookRelation lbr ON b.BookID = lbr.BookID 
        JOIN Library l ON lbr.LibraryID = l.LibraryID 
        JOIN Author a ON b.AuthorID = a.AuthorID 
        WHERE l.LibraryID = 'lib101'; -- Replace with the desired LibraryID

    book_rec c1%ROWTYPE; 
BEGIN 
    OPEN c1; 
    LOOP 
        FETCH c1 INTO book_rec; 
        EXIT WHEN c1%NOTFOUND; 

        DBMS_OUTPUT.PUT_LINE('Book ID: ' || book_rec.BookID); 
        DBMS_OUTPUT.PUT_LINE('Title: ' || book_rec.BookTitle); 
        DBMS_OUTPUT.PUT_LINE('Genre: ' || book_rec.BookGenre); 
        DBMS_OUTPUT.PUT_LINE('Published Year: ' || book_rec.BookPublishedYear); 
        DBMS_OUTPUT.PUT_LINE('Author: ' || book_rec.AuthorName); 
        DBMS_OUTPUT.PUT_LINE('---------------------------------------'); 
    END LOOP; 
    CLOSE c1; 
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); 
END;
/

-- List of Authors and Their Books
DECLARE 
    CURSOR c2 IS  
        SELECT a.AuthorName, b.BookTitle, b.BookGenre 
        FROM Author a 
        JOIN Book b ON a.AuthorID = b.AuthorID; 
    
    author_rec c2%ROWTYPE; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of Authors and Their Books:'); 
    OPEN c2; 
    LOOP 
        FETCH c2 INTO author_rec; 
        EXIT WHEN c2%NOTFOUND; 

        DBMS_OUTPUT.PUT_LINE('Author: ' || author_rec.AuthorName); 
        DBMS_OUTPUT.PUT_LINE('Title: ' || author_rec.BookTitle); 
        DBMS_OUTPUT.PUT_LINE('Genre: ' || author_rec.BookGenre); 
        DBMS_OUTPUT.PUT_LINE('---------------------------------------'); 
    END LOOP; 
    CLOSE c2; 
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); 
END;
/

-- Comparison of Libraries Based on the Number of Books
DECLARE 
    v_library_name Library.LibraryName%TYPE; 
    v_book_count NUMBER; 
    CURSOR c3 IS  
        SELECT l.LibraryName, COUNT(lbr.BookID) AS BookCount 
        FROM Library l 
        LEFT JOIN LibraryBookRelation lbr ON l.LibraryID = lbr.LibraryID 
        GROUP BY l.LibraryName; 
    
    library_rec c3%ROWTYPE; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Comparison of Libraries Based on the Number of Books:'); 
    OPEN c3; 
    LOOP 
        FETCH c3 INTO library_rec; 
        EXIT WHEN c3%NOTFOUND; 

        DBMS_OUTPUT.PUT_LINE('Library: ' || library_rec.LibraryName); 
        DBMS_OUTPUT.PUT_LINE('Number of Books: ' || library_rec.BookCount); 
        DBMS_OUTPUT.PUT_LINE('---------------------------------------'); 
    END LOOP; 
    CLOSE c3; 
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); 
END;
/

-- Books by Genre
DECLARE 
    CURSOR c4 IS  
        SELECT BookGenre, COUNT(*) AS GenreCount 
        FROM Book 
        GROUP BY BookGenre; 
    
    genre_rec c4%ROWTYPE; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Count of Books by Genre:'); 
    OPEN c4; 
    LOOP 
        FETCH c4 INTO genre_rec; 
        EXIT WHEN c4%NOTFOUND; 

        DBMS_OUTPUT.PUT_LINE('Genre: ' || genre_rec.BookGenre); 
        DBMS_OUTPUT.PUT_LINE('Number of Books: ' || genre_rec.GenreCount); 
        DBMS_OUTPUT.PUT_LINE('---------------------------------------'); 
    END LOOP; 
    CLOSE c4; 
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); 
END;
/
