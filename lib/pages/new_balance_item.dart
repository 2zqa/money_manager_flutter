import 'package:flutter/material.dart';

class NewBalanceItemForm extends StatefulWidget {
  @override
  NewBalanceItemFormState createState() {
    return NewBalanceItemFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class NewBalanceItemFormState extends State<NewBalanceItemForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16), // TODO check material spec for padding
      child: Wrap(
        // Use wrap so spacing is available
        spacing: 20,
        runSpacing: 20,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Name",
              filled: true,
              border: OutlineInputBorder(),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              suffixText: "Euros",
              filled: true,
              border: OutlineInputBorder(),
              labelText: "Amount",
            ),
          ),
        ],
      ),
    );
  }
}

class NewBalanceItemRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("New balance item"),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "INCOME",
              ),
              Tab(
                text: "EXPENSE",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            NewBalanceItemForm(),
            NewBalanceItemForm(),
          ],
        ),
      ),
    );
  }
}
