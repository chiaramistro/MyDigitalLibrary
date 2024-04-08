# MyDigitalLibrary

This app allows users to save their favorite books and authors for easy access. Whether you're an avid reader or simply enjoy keeping track of your favorite authors, MyDigitalLibrary has got you covered. This documentation will guide you through the various features and functionalities of the app.

## Table of Contents
1. [Home](#home)
2. [Search](#search)
3. [Details](#details)
4. [Key Functionalities](#Functionalities)
4. [App Build](#Build)

## Home
The "Home" page is composed by two tabs where the user can view and manage their favorite books and authors. There are two dedicated tabs:
- **Books Tab**: user can see their favourite books. Each entry displays the title of the book.
- **Author Tab**: user can see their favourite books. Each entry displays the name of the author.

From this page users can add (using the plus "+" button on the top right corner) or remove their entries (from their details view) from their favorites list. 

## Search
The **"Search" tab** provides users with the ability to search for specific books or authors. Upon entering a title or a name in the search bar, a list of relevant results is displayed. Users can swipe left on an item in the list to add it to their favorites. This feature makes it easy to quickly add new favorites without navigating away from the search results.

## Details
The **"Details" page** allows users to view additional information about a selected book or author. This includes details such as:
- for the books, the book's cover and synopsis;
- for the authors, author's photo and biography. 
Users can access this page by tapping on a book or author from their favorites list.
From this page it is possible to remove an item from your favorites list by tapping on the heart icon on top right corner of the book or author you wish to remove.

## Functionalities
The key functionalities that make our app unique are:
- **User Interface**: multiple screens to view the content of the app, such as the list of favourites and the details of a book or author;
- **Networking**: [OpenLibrary.org]("https://openlibrary.org/") suite, which offers a long list of books and authors to search from. No API key is needed;
- **Persistent State**: usage of CoreData to save your lists of favourites inside your device, so that you can access them anytime.

## Build
Clone the repo in your local machine and build the app as it is. No special configurations or API keys are needed. 


Thank you for using MyDigitalLibrary! Have fun organizing and discovering your favorite books and authors with our app. 
Happy reading! 📚