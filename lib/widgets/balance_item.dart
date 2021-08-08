import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Logic
enum RecurringType { daily, weekly, fortnightly, monthly, yearly }

abstract class BalanceItem {
  String name;
  int cost;
  RecurringType recurringType;

  BalanceItem(this.name, this.cost, this.recurringType);
}

class Expense extends BalanceItem {
  Expense(String name, int cost, RecurringType recurringType)
      : super(name, cost, recurringType);
}

class Income extends BalanceItem {
  Income(String name, int cost, RecurringType recurringType)
      : super(name, cost, recurringType);
}

// TODO: sort by next payment date
enum SortingMethod { price, name }

class BalanceItemListModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Income> _incomeList = [
    Income("Duo", 25000, RecurringType.daily),
    Income("Ouders", 10000, RecurringType.daily),
    Income("Salaris", 200000, RecurringType.daily),
  ];
  final List<Expense> _expenseList = [
    Expense("Spotify", 500, RecurringType.daily),
    Expense("Huur", 30000, RecurringType.daily),
    Expense("Extra kosten huis", 7500, RecurringType.daily),
  ];

  BalanceItemListModel() {
    // TODO: remove this along with dummy data
    sortBy(this.sortingMethod);
  }

  SortingMethod sortingMethod = SortingMethod.price;

  /// Sorts both lists by [sortingMethod].
  /// TODO: add ascending/descending method
  void sortBy(SortingMethod sortingMethod) {
    this.sortingMethod = sortingMethod;
    switch (sortingMethod) {
      case SortingMethod.price:
        _expenseList.sort((a, b) => b.cost - a.cost);
        _incomeList.sort((a, b) => b.cost - a.cost);
        break;
      case SortingMethod.name:
        _expenseList.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        _incomeList.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
    }
    notifyListeners();
  }

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Income> get incomeList =>
      UnmodifiableListView(_incomeList);

  UnmodifiableListView<Expense> get expenseList =>
      UnmodifiableListView(_expenseList);

  /// The current total price of all items (in cents, as always)
  int get totalPrice {
    int totalPrice = 0;
    for (var income in _incomeList) {
      totalPrice += income.cost;
    }
    for (var expense in _expenseList) {
      totalPrice += expense.cost;
    }
    return totalPrice;
  }

  /// Adds [item] to to the list
  void addExpense(Expense item) {
    _expenseList.add(item);
    sortBy(this.sortingMethod);
    notifyListeners();
  }

  /// Adds [item] to to the list
  void addIncome(Income item) {
    _incomeList.add(item);
    sortBy(this.sortingMethod);
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _incomeList.clear();
    _expenseList.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}

// Widgets
class BalanceItemCard extends StatelessWidget {
  final BalanceItem balanceItem;
  final String localeString;

  String _formatMoney(String localeString, int cents) =>
      NumberFormat.simpleCurrency(locale: localeString).format(cents / 100);

  /// A visual representation of a [BalanceItem].
  /// Therefore, it requires one (duh)
  const BalanceItemCard(
      {required this.balanceItem, required this.localeString, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
        onTap: () {
          print('Card tapped.');
        },
        child: ListTile(
          leading: Icon(
            this.balanceItem is Income
                ? Icons.arrow_upward
                : Icons.arrow_downward,
          ),
          title: Text(this.balanceItem.name),
          subtitle: Text(_formatMoney(localeString, balanceItem.cost)),
        ),
      ),
    );
  }
}
