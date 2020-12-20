import 'dart:convert';
import 'package:book_depo/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:book_depo/detailscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookList;
  double screenHeight, screenWidth;
  String _titlecenter = "Book Loading...."; 
  

  @override
  void initState() {
  super.initState();
  _loadBook();
      }
  
  @override
    Widget build(BuildContext context) {
      screenHeight = MediaQuery.of(context).size.height;
      screenWidth = MediaQuery.of(context).size.width; 

      return Scaffold(
          appBar: AppBar(
            title: Text('Main Page'),
          ),
          body: Column(
            children:<Widget> [
              bookList == null 
              ? Flexible(
                child:Container(
                  child: Center(
                    child: Text(
                      _titlecenter,
                      style: TextStyle(
                        fontSize:18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))))) 
              : Flexible(
                child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (screenWidth / screenHeight) / 0.8,
                children: List.generate(bookList.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                      child: InkWell(
                      onTap: () => _loadBookDetail(index),
                      child: SingleChildScrollView(
                             child: Column(
                               children: [
                                Container(
                                  height: screenHeight / 3.8,
                                  width: screenWidth / 1.2,
                                  child: CachedNetworkImage(
                                  imageUrl:
                                     "http://slumberjer.com/bookdepo/bookcover/${bookList[index]['cover']}.jpg",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => 
                                        new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => 
                                          new Icon(
                                                Icons.broken_image,
                                                size: screenWidth / 2,
                                          ),
                                          )), 
                                          SizedBox(height: 5),
                                          Text(
                                           bookList[index]['booktitle'],
                                            style: TextStyle(
                                            fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                                ),
                                              Text(bookList[index]['author']),
                                              Text(bookList[index]['description']),
                                            ],
                                          ),
                                        ),
                                      )));
                                    }),
                                  ))
                                  ],
                                  ),
                                   );
                                  }
                            
                          
                        
                      
                      
                      
                      
                      
void _loadBook() {
    http.post("http://slumberjer.com/bookdepo/php/load_books.php",
    body: {}).then((res) {
    print(res.body);
    if (res.body == "nodata") {
      bookList = null;
      setState(() {
      _titlecenter = "No Book Found";
      });
    } else {
      setState(() {
        var jsondata = json.decode(res.body);
        bookList = jsondata["books"];
      });
      }
      }).catchError((err) {
        print(err);
 });
}
                      
_loadBookDetail(int index) async {
  ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    await pr.show();
   print(bookList[index]['bookname']);
    Book book = new Book(
        bookid: bookList[index]['bookid'],
        booktitle: bookList[index]['booktitle'],
        author: bookList[index]['author'],
        price: bookList[index]['price'],
        description: bookList[index]['description'],
        rating: bookList[index]['rating'],
        publisher: bookList[index]['publisher'],
        isbn: bookList[index]['isbn'],
        cover: bookList[index]['cover']);

        await pr.hide();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookDetailScreen(
                  book: book,
                )));
}
}
