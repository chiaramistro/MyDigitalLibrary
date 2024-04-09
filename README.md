# MyDigitalLibrary

This app allows users to save their favorite books and authors for easy access. Whether you're an avid reader or simply enjoy keeping track of your favorite authors, MyDigitalLibrary has got you covered. This documentation will guide you through the various features and functionalities of the app.

## Table of Contents
1. [Home](#home)
2. [Search](#search)
3. [Details](#details)
4. [Key Functionalities](#functionalities)
4. [App Build](#build)
4. [Other](#other)

## Home
The "Home" page is composed by two tabs where the user can view and manage their favorite books and authors. There are two dedicated tabs:
- **Books Tab**: user can see their favourite books. Each entry displays the title and the author of the book.
- **Author Tab**: user can see their favourite books. Each entry displays the name and a photo of the author.

From this page users can add (using the plus "+" button on the top right corner) or remove their entries (from their details view) from their favorites list. 

## Search
The **"Search" tab** provides users with the ability to search for specific books or authors. Upon entering a title or a name in the search bar, a list of relevant results is displayed. Users can swipe left on an item in the list to add it to their favorites. This feature makes it easy to quickly add new favorites without navigating away from the search results.

## Details
The **"Details" page** allows users to view additional information about a selected book or author. Users can access this page by tapping on a book or author from their favorites list. The details view includes:
- for the books, the book's cover and synopsis;
- for the authors, author's photo and biography. 
Note that some of the information about a book or author may not be present due to the lack of data in the OpenLibrary database.
From this page it is possible to remove an item from your favorites list by tapping on the heart icon on top right corner of the book or author you wish to remove.

## Functionalities
The key functionalities that make our app unique are:
- **User Interface**: multiple screens to view the content of the app, such as the list of favourites and the details of a book or author;
- **Networking**: [OpenLibrary.org]("https://openlibrary.org/") suite, which offers a long list of books and authors to search from. No API key is needed;
- **Persistent State**: usage of CoreData to save your lists of favourites inside your device, so that you can access them anytime.

## Build
Clone the repo in your local machine and build the app as it is. No special configurations or API keys are needed. 


## Other
Credits to [Icons8]("https://icons8.com") for the [Love Book icon]("https://icons8.com/icon/pXJTVvE8w6Ub/love-book").

Thank you for using MyDigitalLibrary! Have fun organizing and discovering your favorite books and authors with our app. 
Happy reading! 📚



COSE DA FARE:
- FIXME aggiungere popup errori - The app displays an alert view if the network connection fails.

- NO? - TODO add author from details view (solo autore, non libro)
- TODO The app clearly indicates network activity, displaying activity indicators and/or progress bars when appropriate.
- TODO aggiungere una riga di dettaglio (sottotitolo) anche nei dettagli libro per far vedere l'autore?
