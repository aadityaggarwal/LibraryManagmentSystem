# Library Management System

This repository contains SQL scripts for managing a Library Management System. The system includes tables for libraries, authors, books, and their relationships, as well as PL/SQL scripts for various operations such as displaying book details, listing authors and their books, comparing libraries, and counting books by genre.

## Table of Contents

- [Database Structure](#database-structure)
- [PL/SQL Scripts](#plsql-scripts)

## Database Structure

### Tables

- **Library**: Stores information about libraries, including their ID, name, address, email, and the number of books.
- **Author**: Stores information about authors, including their ID, name, email, and nationality.
- **Book**: Stores information about books, including their ID, title, genre, published year, and the author ID.
- **LibraryBookRelation**: A junction table that links libraries and books.

### Example Data

Sample data has been inserted into the tables to demonstrate the functionality of the PL/SQL scripts.

## PL/SQL Scripts

### 1. Display Book Details in a Specific Library

This script displays all the books available in a specific library along with their details like title, genre, published year, and the author's name.

### 2. List of Authors and Their Books

This script generates a list of authors and the books they have written.

### 3. Comparison of Libraries Based on the Number of Books

This script compares different libraries based on the number of books they hold.

### 4. Books by Genre

This script counts the number of books for each genre available in the system.


