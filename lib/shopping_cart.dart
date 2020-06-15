import 'package:flutter/material.dart';
import './helpers/db_helpers.dart';
import 'package:flutter/foundation.dart';

List<CartTransaction> items = [];

class CartTransaction {
  final String id;
  final String title;
  final String amount;
  final String info;

  CartTransaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.info,
  });
}

Future<void> fetchTransactions() async {
  final dataList = await DBHelper.getData('user_cart');
  items = dataList
      .map(
        (item) => CartTransaction(
          id: item['id'],
          title: item['title'],
          amount: item['amount'],
          info: item['info'],
        ),
      )
      .toList();
  return items;
}

class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: FutureBuilder(
        future: fetchTransactions(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: items.length,
                      itemBuilder: (ctx, i) => Dismissible(
                        direction: DismissDirection.endToStart,
                        key: ValueKey(ctx),
                        background: Container(
                          color: Colors.red,
                          child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.cancel,
                                color: Colors.white,
                              )),
                        ),
                        onDismissed: (direction) {
                          debugPrint('i is: ' + i.toString());
                          debugPrint('Count data is: ' + items[i].id.toString());
                          items.removeAt(i);
                          //DBHelper.remove('user_cart', items[i].id);
                        },
                        child: ListTile(
                          onLongPress: () => {},
                          title: Text(items[i].title),
                          subtitle: Row(
                            children: <Widget>[
                              Text('#' + items[i].id + ' '),
                              Text(items[i].info),
                            ],
                          ),
                          trailing: Text('\$' + items[i].amount),
                          onTap: () {
                            // Go to detail page ...
                          },
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
