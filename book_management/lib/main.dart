import 'package:flutter/material.dart';

void main() {
  runApp(BookManagementApp());
}

class BookManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BookListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});
}

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  // List to store books in memory
  final List<Book> _books = [];

  // Controllers for text fields
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  // Method to add a new book
  void _addBook() {
    final title = _titleController.text.trim();
    final author = _authorController.text.trim();

    if (title.isNotEmpty && author.isNotEmpty) {
      setState(() {
        _books.add(Book(title: title, author: author));
        _titleController.clear();
        _authorController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both title and author')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Management'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form to add a new book
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Book Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: 'Author',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addBook,
              child: Text('Add Book'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Text color
              ),
            ),
            SizedBox(height: 20),
            // Display list of books
            Expanded(
              child:
                  _books.isEmpty
                      ? Center(child: Text('No books added yet'))
                      : ListView.builder(
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          final book = _books[index];
                          return ListTile(
                            title: Text(book.title),
                            subtitle: Text('by ${book.author}'),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
