import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'book.dart';


class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({Key key, this.book}) : super(key: key); 

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  double screenHeight, screenWidth; 

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
 
 return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.booktitle),
        ),
      body: Center(
        child: Padding(
                padding:
                    EdgeInsets.all(30),
        child: SingleChildScrollView(
        child: Column(children: [
          Container(
          height: screenHeight / 1.6,
          width: screenWidth / 1.5,
          child: CachedNetworkImage(
          imageUrl:"http://slumberjer.com/bookdepo/bookcover/${widget.book.cover}.jpg",
          fit: BoxFit.cover,
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(
            Icons.broken_image,
        size: screenWidth / 2,
 ),
 )),
 Container(
    child: Column(children: [
      SizedBox(height: 5),
      Text(widget.book.booktitle,
      textAlign: TextAlign.center,
      style: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      )),
 ]),
 ),
Container(
    child: Column(children: [
      SizedBox(height: 5),
      Text(
      widget.book.author,
      textAlign: TextAlign.center,
      style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      )),
SizedBox(height: 8),
      Row(children: [
          RichText(
           text: TextSpan(
              style:
              TextStyle(color: Colors.black, fontSize: 14),
                children: <TextSpan>[              
              TextSpan(
                text: "Rating: ",
                style: TextStyle(
                fontSize: 12,
                  )),
                TextSpan(text: widget.book.rating)
              ])),
      ]),
SizedBox(height: 8),
      Row(children: [
          RichText(
           text: TextSpan(
              style:
              TextStyle(color: Colors.black, fontSize: 14),
                children: <TextSpan>[              
              TextSpan(
                text: "Price: RM ",
                style: TextStyle(
                fontSize: 12,
                  )),
                TextSpan(text: widget.book.price)
              ])),
      ]),
SizedBox(height: 8),
      Row(children: [
          RichText(
           text: TextSpan(
              style:
              TextStyle(color: Colors.black, fontSize: 14),
                children: <TextSpan>[              
              TextSpan(
                text: "Publisher: ",
                style: TextStyle(
                fontSize: 12,
                  )),
                TextSpan(text: widget.book.publisher)
              ])),
      ]),
SizedBox(height: 8),
      Row(children: [
          RichText(
           text: TextSpan(
              style:
              TextStyle(color: Colors.black, fontSize: 14),
                children: <TextSpan>[              
              TextSpan(
                text: "ISBN: ",
                style: TextStyle(
                fontSize: 12,
                  )),
                TextSpan(text: widget.book.isbn)
              ])),
      ]),
SizedBox(height: 10),
      Row(children: [
          RichText(
           text: TextSpan(
              style:
              TextStyle(color: Colors.black, fontSize: 14),
                children: <TextSpan>[              
              TextSpan(
                text: "Discrption:\n",
                style: TextStyle(
                fontSize: 14,
                  )),
                TextSpan(text: widget.book.description)
              ])),
      ]),
      ])
  )]
  )
  ),
  )
  ));

 } 
}