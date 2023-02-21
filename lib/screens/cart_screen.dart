import 'package:flutter/material.dart';
import 'package:movieex/providers/cart.dart';
import 'package:movieex/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = './cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    //
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(fontSize: mediaQueryH / 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          height: mediaQueryH / 19,
          width: mediaQueryW / 2.5,
          child: RaisedButton(
            color: Colors.red[700],
            child: Text(
              'ORDER NOW!',
              style: TextStyle(
                  fontSize: mediaQueryH / 53, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {},
            textColor: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: mediaQueryH / 50, horizontal: mediaQueryW / 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                          fontSize: mediaQueryH / 38,
                          color: Theme.of(context).hintColor),
                    ),
                    Text(
                      '  ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: mediaQueryH / 38,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    Text(
                      ' SDG',
                      style: TextStyle(
                        fontSize: mediaQueryH / 75,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: cart.items.isEmpty
                ? Center(
                    child: Text(
                      'Cart is empty!',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      return CartIt(
                        cart.items.values.toList()[i].id,
                        cart.items.keys.toList()[i],
                        cart.items.values.toList()[i].price,
                        cart.items.values.toList()[i].quantity,
                        cart.items.values.toList()[i].title,
                        cart.items.values.toList()[i].image,
                        cart.items.values.toList()[i].rate,
                        cart.items.values.toList()[i].date,
                      );
                    }),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed:
          (widget.cart.totalAmount <= 0 || _isLoading) ? null : () async {},
      textColor: Theme.of(context).primaryColor,
    );
  }
}
