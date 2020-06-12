import 'package:flutter/material.dart';
import './shopping_cart.dart';
import './transaction.dart';
import './helpers/db_helpers.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sephora Shop',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.purple,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                )),
          )),
    );
  }
}

class MyHomePage extends StatelessWidget {


  void selectShoppingCart(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ShoppingCartScreen();
        },
      ),
    );
  }

  void selectedItemNow(
    String pickedId,
    String pickedTitle,
    String pickedAmount,
    String pickedInfo,
  ) {
    DBHelper.insert(
      'user_cart',
      {
        'id': pickedId,
        'title': pickedTitle,
        'amount': pickedAmount,
        'info': pickedInfo,
      },
    );
  }

      Future<String> fetchItemNumber() async {
    final dataList = await DBHelper.getData('user_cart'); 
        items = dataList
        .map(
          (item) => CartTransaction(
                id: item['id'],
                title: item['title'],
                amount: item['amount'],
                info: item['info'],
              ),
        ).toList(); 
        final itemCount = items.length.toString();
        return itemCount;   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sephora Store'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Stack(children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => selectShoppingCart(context),
            ),
            Positioned(
              top: 20,
              child: Container(
                child: 
                FutureBuilder(
        future: fetchItemNumber(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? 
                  CircularProgressIndicator() 
                : 
                  Text(
                  itemCount,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:17,
                  ),
                ), 
                ),
                width: 20,
                height: 20,
                decoration: new BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ])
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: transactions.map((tx) {
                return Container(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '\$${tx.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                tx.title,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.title,
                              ),
                              Text(
                                tx.info,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                MaterialButton(
                                  height: 20,
                                  minWidth: 15,
                                  color: Colors.grey[200],
                                  child: Icon(Icons.add_shopping_cart),
                                  splashColor: Colors.blue,
                                  onPressed: () => selectedItemNow(
                                    tx.id,
                                    tx.title,
                                    tx.amount.toStringAsFixed(2),
                                    tx.info,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                MaterialButton(
                                    height: 20,
                                    minWidth: 15,
                                    child: Text('Qty'),
                                    color: Colors.grey[200],
                                    splashColor: Colors.blue,
                                    onPressed: () {}),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
