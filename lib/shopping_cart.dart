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
    debugPrint('before items are: ' + dataList.toString());   
        items = dataList
        .map(
          (item) => CartTransaction(
                id: item['id'],
                title: item['title'],
                amount: item['amount'],
                info: item['info'],
              ),
        ).toList();
        debugPrint('items are :' + items.toString());  
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
                        itemCount: items.length,
                        itemBuilder: (ctx, i) => ListTile(
                              title: Text(items[i].title),
                              subtitle: Text(items[i].info),
                              onTap: () {
                                // Go to detail page ...
                              },
                            ),
                      ),
                  ),
      ),
    );
  }
}
