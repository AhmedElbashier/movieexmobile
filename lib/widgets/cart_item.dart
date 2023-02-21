import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartIt extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String date;
  final double rate;
  final String image;

  CartIt(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.image,
    this.rate,
    this.date,
  );

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Dismissible(
          key: ValueKey(id),
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete,
              color: Theme.of(context).hintColor,
              size: 20,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
          ),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: Colors.grey[900],
                title: Text(
                  'Are you sure?',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                content: Text(
                  'Do you want to remove the item from the cart?',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'No',
                      style: TextStyle(
                          color: Colors.red[500], fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          color: Colors.red[500], fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ),
            );
          },
          onDismissed: (direction) {
            Provider.of<Cart>(context, listen: false).removeItem(productId);
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.only(right: mediaQueryW / 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: SizedBox(
                          width: mediaQueryW / 5,
                          child: Image.network(
                              'https://image.tmdb.org/t/p/w500$image')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: EdgeInsets.only(top: mediaQueryH / 100),
                            child: Row(
                              children: [
                                Text(
                                  rate.toStringAsFixed(1),
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: mediaQueryH / 65),
                                ),
                                Icon(
                                  Icons.star,
                                  size: mediaQueryH / 50,
                                  color: Colors.yellow[800],
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${(price * quantity)}',
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize: mediaQueryH / 50)),
                              Text(' SDG',
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize: mediaQueryH / 80)),
                            ],
                          ),
                          SizedBox(
                            height: mediaQueryH / 150,
                          ),
                          Text('$quantity x',
                              style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: mediaQueryH / 52)),
                        ],
                      ),
                    ),
                  ]),
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
                    child: Text(
                      '| |',
                      style: TextStyle(
                          color: Colors.grey[900], fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Divider(
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
