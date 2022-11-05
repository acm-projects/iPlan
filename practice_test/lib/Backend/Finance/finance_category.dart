import 'package:flutter/material.dart';

import 'expense.dart';

/// @author [MatthewSheldon]
/// The [FinanceCategory] object represents an entire group of Expense objects
/// with a common theme. This is used in tandem with the [FinancePage] class.
class FinanceCategory {
  /// The name of the finance category
  late String _categoryName;

  /// The amount of unspent budget for the category
  late double _budgetRemaining;

  /// The amount of spent budget for the category
  late double _budgetUsed;

  /// The total allocated budget for the category
  late double _totalBudget;

  /// The color of the category
  late Color _color;

  /// The list of the individual expenses for the category
  late List<Expense> _listOfExpenses;

  /// Creates a [FinanceCategory] Object with parameters [name], [budget] and [color]
  FinanceCategory(
      {required String name, required double budget, required Color color}) {
    _categoryName = name;
    _totalBudget = budget;
    _budgetRemaining = budget;
    _budgetUsed = 0;
    _color = color;
    _listOfExpenses = <Expense>[];
  }

  /// Constructs a [FinanceCategory] object from the passed [json] file
  FinanceCategory.fromJson({required Map<String, dynamic> json}) {
    _categoryName = json["categoryName"];
    _budgetRemaining = json["budgetRemaining"];
    _budgetUsed = json["budgetUsed"];
    _totalBudget = json["totalBudget"];
    _color = Color(int.parse(json["color"], radix: 16));
    List<dynamic> expensesData = json["expenses"] as List<dynamic>;
    _listOfExpenses =
        expensesData.map((expense) => Expense.fromJson(json: expense)).toList();
  }

  /// Inserts the passed [newExpense] item into the [_listOfExpenses] in order
  /// with respect to alphabetic order. Additionally, update the [_budgetUsed]
  /// and [_budgetRemaining]
  void addItem({required Expense newExpense}) {
    // Iterate through the list and find the place to insert it.
    for (int i = 0; i < _listOfExpenses.length; i++) {
      if (_listOfExpenses[i]
              .getExpenseName()
              .compareTo(newExpense.getExpenseName()) >
          0) {
        _listOfExpenses.insert(i, newExpense);
        _budgetUsed += newExpense.getExpenseBudget();
        _budgetRemaining = _totalBudget - _budgetUsed;
        return;
      }
    }
    // Otherwise, add it at the end
    _listOfExpenses.add(newExpense);
    _budgetUsed += newExpense.getExpenseBudget();
    _budgetRemaining = _totalBudget - _budgetUsed;
  }

  /// Removes the [Expense] object described by the passed [expenseName] from
  /// this [FinanceCategory]'s [_listOfExpenses]. Additionally, update the
  /// [_budgetUsed] and [_budgetRemaining].
  void removeItem({required String expenseName}) {
    for (int i = 0; i < _listOfExpenses.length; i++) {
      if (_listOfExpenses[i].getExpenseName() == expenseName) {
        Expense removedExpense = _listOfExpenses.removeAt(i);
        _budgetUsed -= removedExpense.getExpenseBudget();
        _budgetRemaining = _totalBudget - _budgetUsed;
        return;
      }
    }
  }

  /// Returns the name given to this [FinanceCategory]
  String getCategoryName() {
    return _categoryName;
  }

  /// Returns the amount of budget that this [FinanceCategory] has used already
  double getBudgetUsedOnCategory() {
    return _budgetUsed;
  }

  /// Returns the amount of budget that this [FinanceCategory] has used already
  double getBudgetRemaining() {
    return _budgetRemaining;
  }

  /// Returns the total budget allocated to this [FinanceCategory]
  double getTotalBudget() {
    return _totalBudget;
  }

  /// Returns the color of this [FinanceCategory]
  Color getColor() {
    return _color;
  }

  /// Returns this [FinanceCategory] object's list of [Expense] objects
  List<Expense> getListOfExpenses() {
    return _listOfExpenses;
  }

  /// Updates the [_categoryName] of this object to be the passed [newCategoryName]
  void updateCategoryName({required String newCategoryName}) {
    _categoryName = newCategoryName;
  }

  /// Updates the [_totalBudget] to be the passed [newBudget] and updates
  /// the [_budgetRemaining] to be the differece of [newBudget] and [_budgetUsed]
  void updateBudget({required double newBudget}) {
    _totalBudget = newBudget;
    _budgetRemaining = _totalBudget - _budgetUsed;
  }

  /// Updates the [_color] of this object to be the passed [newColor]
  void updateColor({required Color newColor}) {
    _color = newColor;
  }

  /// Converts the current [FinanceCategory] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "categoryName": _categoryName,
      "budgetRemaining": _budgetRemaining,
      "budgetUsed": _budgetUsed,
      "totalBudget": _totalBudget,
      "color": _color.toString().substring(8, 16),
      "expenses": _listOfExpenses.map((expense) => expense.toJson()).toList()
    };
  }
}
