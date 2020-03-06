#include <stdio.h>
#include <string.h>

typedef struct Books {
  char title[50];
  char author[50];
  char subject[100];
  int book_id;
} Book;

void printBook(Book *b);

int main() {
  Book book;
  Book *ptr_book = &book;

  strcpy(book.title, "C Programming");
  strcpy(book.author, "Nuha Ali"); 
  strcpy(book.subject, "C Programming Tutorial");
  book.book_id = 6495407;

  printBook(ptr_book);
  printBook(&book);
  return 0;
}

void printBook(Book *book) {
  printf( "Book title : %s\n", book->title);
  printf( "Book author : %s\n", book->author);
  printf( "Book subject : %s\n", book->subject);
  printf( "Book book_id : %d\n", book->book_id);
  printf( "\n");
  return;
}
