import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Logic
/// How often a payment occurs.
enum RecurringType {
  /// Payment occurs daily.
  daily,

  /// Payment occurs weekly, on the same day every week. For example: Monday.
  weekly,

  /// Payment occurs every two weeks, on the same day every two weeks. For example: Thursday, but not the Thursday thereafter.
  fortnightly,

  /// Payment occurs monthly, on the same date every month. For example: 3rd of January, February, March, etc.
  /// If date does not exist in month (for example, February 31th), it skips the payment.
  monthly,

  /// Payment occurs every year, on the same day. For example: The 200th day.
  yearly,
}

/// An abstract balance item, which can be an income or an expense.
/// Contains field related to recurring income or expenses.
///
/// See also:
///  * [Income]
///  * [Expense]
abstract class BalanceItem {
  /// Convert a BalanceItem into a Map. The keys must correspond to the names of
  /// the columns in the database.
  Map<String, dynamic> toMap();

  BalanceItem(this.name, this.cost, this.recurringType);

  String name;

  /// The amount of money in cents.
  int cost;

  /// How often the payment occurs. See: [RecurringType]
  RecurringType recurringType;
}

class Expense extends BalanceItem {
  Expense(String name, int cost, RecurringType recurringType)
      : super(name, cost, recurringType);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cost': cost,
    };
  }
}

class Income extends BalanceItem {
  Income(String name, int cost, RecurringType recurringType)
      : super(name, cost, recurringType);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cost': cost,
    };
  }
}

// TODO: sort by next payment date
enum SortingMethod { price, name }

/// Model that handles keeping track of balance items and keeping the visual
/// representation up-to-date. Balance items are saved in a SQL database and
/// in lists.
class BalanceItemListModel extends ChangeNotifier {
  /// Creates the model.
  BalanceItemListModel() {
    init();
  }

  /// Reference to the database, used for storing balance items.
  late final Database _database;

  /// Initializes the database, creating two tables
  /// and then running [populateFields].
  Future<void> init() async {
    return openDatabase(
      join(await getDatabasesPath(), 'money_manager.db'),
      onCreate: (Database db, int version) {
        db.execute(
          'CREATE TABLE income_items(id INTEGER PRIMARY KEY, name TEXT, cost INTEGER)',
        );
        db.execute(
          'CREATE TABLE expense_items(id INTEGER PRIMARY KEY, name TEXT, cost INTEGER)',
        );
      },
      version: 1,
    ).then((Database db) => populateFields(db));
  }

  /// Populates the internal expense and income lists and the _database field.
  Future<void> populateFields(Database db) async {
    // Save the db parameter in object
    _database = db;

    // Query items from database
    final List<Map<String, dynamic>> expenseItemMap =
        await _database.query('expense_items');
    final List<Map<String, dynamic>> incomeItemMap =
        await _database.query('income_items');

    // Populate the iternal lists
    for (final Map<String, dynamic> rawExpense in expenseItemMap) {
      final String name = rawExpense['name'] as String;
      final int cost = rawExpense['cost'] as int;
      _expenseList.add(Expense(name, cost, RecurringType.daily));
    }
    for (final Map<String, dynamic> rawIncome in incomeItemMap) {
      final String name = rawIncome['name'] as String;
      final int cost = rawIncome['cost'] as int;
      _incomeList.add(Income(name, cost, RecurringType.daily));
    }
    sortBy(sortingMethod);
    notifyListeners();
  }

  /// Internal, private state of all income and expenses.
  final List<Income> _incomeList = <Income>[];
  final List<Expense> _expenseList = <Expense>[];

  /// The last used sorting method.
  SortingMethod sortingMethod = SortingMethod.price;

  /// Sorts both lists by [sortingMethod].
  /// TODO: add ascending/descending method
  void sortBy(SortingMethod sortingMethod) {
    this.sortingMethod = sortingMethod;
    switch (sortingMethod) {
      case SortingMethod.price:
        _expenseList.sort((Expense a, Expense b) => b.cost - a.cost);
        _incomeList.sort((Income a, Income b) => b.cost - a.cost);
        break;
      case SortingMethod.name:
        _expenseList.sort((Expense a, Expense b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        _incomeList.sort((Income a, Income b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
    }
    notifyListeners();
  }

  /// An unmodifiable view of all income items.
  /// Can be interated over for visual representations.
  ///
  /// See also:
  ///  * [expenseList]
  UnmodifiableListView<Income> get incomeList =>
      UnmodifiableListView<Income>(_incomeList);

  /// An unmodifiable view of all expenses.
  /// Can be interated over for visual representations.
  ///
  /// See also:
  ///  * [incomeList]
  UnmodifiableListView<Expense> get expenseList =>
      UnmodifiableListView<Expense>(_expenseList);

  /// The current total price of all items (in cents, as always).
  int get totalPrice {
    int totalPrice = 0;
    for (final Income income in _incomeList) {
      totalPrice += income.cost;
    }
    for (final Expense expense in _expenseList) {
      totalPrice -= expense.cost;
    }
    return totalPrice;
  }

  bool get isNetPositive => totalPrice >= 0;

  /// Adds an expense to the database, replacing if it already exists
  Future<int> _addExpenseToDB(Expense item) async {
    return _database.insert(
      'expense_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Adds an income to the database, replacing if it already exists
  Future<int> _addIncomeToDB(Income item) async {
    return _database.insert(
      'income_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Adds [item] to the expenses.
  void addExpense(Expense item) {
    _expenseList.add(item);
    sortBy(sortingMethod);
    notifyListeners();
    _addExpenseToDB(item);
  }

  /// Adds [item] to the income list.
  void addIncome(Income item) {
    _incomeList.add(item);
    sortBy(sortingMethod);
    notifyListeners();
    _addIncomeToDB(item);
  }

  /// Removes all expenses and income.
  void removeAll() {
    _incomeList.clear();
    _expenseList.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}

// Widgets
class BalanceItemCard extends StatelessWidget {
  /// A visual representation of a [BalanceItem].
  /// Therefore, it requires one (duh).
  ///
  /// The [localeString] is used to display the correct currency
  /// and to format the number the way the locale prescribes.
  const BalanceItemCard(
      {required this.balanceItem, required this.localeString, Key? key})
      : super(key: key);

  /// The balanceItem this represents.
  final BalanceItem balanceItem;

  /// The locale that is used to display the correct currency
  /// and to format the number the way this describes
  final String localeString;

  String _formatMoney(String localeString, int cents) =>
      NumberFormat.simpleCurrency(locale: localeString).format(cents / 100);

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
            balanceItem is Income ? Icons.arrow_upward : Icons.arrow_downward,
          ),
          title: Text(balanceItem.name),
          subtitle: Text(_formatMoney(localeString, balanceItem.cost)),
        ),
      ),
    );
  }
}
