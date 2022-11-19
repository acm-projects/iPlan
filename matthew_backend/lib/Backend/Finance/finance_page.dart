import 'package:flutter/material.dart';

import 'expense.dart';
import 'finance_category.dart';

/// @author [MatthewSheldon]
/// The [FinancePage] class represents all of the information and operations
/// that are critical for the finance page-related information to be processed,
/// stored, and updated.
class FinancePage {
  /// The total budget allocated to the current event
  late double _totalBudget;

  /// The amount of budget that has already been allocated
  late double _budgetSpent;

  /// The amount of budget that has not been allocated
  late double _budgetRemaining;

  /// The list of different [FinanceCategory] objects that compose the [_budgetSpent]
  late List<FinanceCategory> _listOfCategories;

  /// Constructs a [FinancePage] object with the passed [totalBudget]
  FinancePage({required double totalBudget}) {
    _totalBudget = totalBudget;
    _budgetRemaining = totalBudget;
    _budgetSpent = 0;
    _listOfCategories = [
      FinanceCategory(
          name: "Discretionary",
          budget: totalBudget,
          color: const Color(0xFFE7E7E7))
    ];
  }

  /// Constructs a [FinancePage] object from the passed [json] file
  FinancePage.fromJson({required Map<String, dynamic> json}) {
    _totalBudget = json["totalBudget"];
    _budgetSpent = json["budgetSpent"];
    _budgetRemaining = json["budgetRemaining"];
    List<dynamic> categoriesData = json["financeCategories"] as List<dynamic>;
    _listOfCategories = categoriesData
        .map((financeCategory) =>
            FinanceCategory.fromJson(json: financeCategory))
        .toList();
  }

  /// Updates the [_totalBudget] to be the passed [newBudget] and updates
  /// [_budgetRemaining].
  void updateTotalBudget({required double newBudget}) {
    _totalBudget = newBudget;
    _budgetRemaining = _totalBudget - _budgetSpent;
  }

  /// Adds a new [FinanceCategory] to [_listOfCategories] described by the
  /// passed [categoryName] and [budget].
  void addCategory(
      {required String categoryName,
      required double budget,
      required Color color}) {
    FinanceCategory newCategory =
        FinanceCategory(name: categoryName, budget: budget, color: color);
    _listOfCategories.insert(_listOfCategories.length - 1,
        newCategory); // Add the category at the end of the list, but before discretionary
    _budgetSpent += budget;
    _budgetRemaining = _totalBudget - _budgetSpent;
  }

  /// Removes a [FinanceCategory] from [_listOfCategories] described by the
  /// passed [categoryName].
  void removeCategory({required String categoryName}) {
    for (int i = 0; i < _listOfCategories.length; i++) {
      if (_listOfCategories[i].getCategoryName() == categoryName) {
        FinanceCategory removedCategory = _listOfCategories.removeAt(i);
        _budgetSpent -= removedCategory.getTotalBudget();
        _budgetRemaining = _totalBudget - _budgetSpent;
        return;
      }
    }
  }

  /// Adds an [Expense] object described by the [expenseName] and
  /// [expenseBudget] to a [FinanceCategory] described by [categoryName]
  /// contained within [_listOfCategories].
  void addExpenseToCategory(
      {required String categoryName,
      required String expenseName,
      required double expenseBudget}) {
    for (int i = 0; i < _listOfCategories.length; i++) {
      if (_listOfCategories[i].getCategoryName() == categoryName) {
        _listOfCategories[i].addItem(
            newExpense: Expense(name: expenseName, budget: expenseBudget));
        return;
      }
    }
  }

  /// Removes an [Expense] object described by [expenseName] from a
  /// [FinanceCategory] object described by [categoryName] contained within
  /// [_listOfCategories].
  void removeExpenseFromCategory(
      {required String categoryName, required String expenseName}) {
    for (int i = 0; i < _listOfCategories.length; i++) {
      if (_listOfCategories[i].getCategoryName() == categoryName) {
        _listOfCategories[i].removeItem(expenseName: expenseName);
        return;
      }
    }
  }

  /// Updates the budget of a [FinanceCategory] described by [categoryName] to
  /// be the value of the passed [newBudget].
  void updateBudgetForCategory(
      {required String categoryName, required double newBudget}) {
    for (int i = 0; i < _listOfCategories.length - 1; i++) {
      if (_listOfCategories[i].getCategoryName() == categoryName) {
        double difference = newBudget - _listOfCategories[i].getTotalBudget();
        _listOfCategories[i].updateBudget(newBudget: newBudget);
        _budgetSpent += difference;
        _budgetRemaining = _totalBudget - _budgetSpent;
        return;
      }
    }
  }

  /// Updates the name of a [FinanceCategory] described by [oldName] to be the
  /// value of the passed [newName].
  void updateCategoryName({required String oldName, required String newName}) {
    for (int i = 0; i < _listOfCategories.length - 1; i++) {
      if (_listOfCategories[i].getCategoryName() == oldName) {
        _listOfCategories[i].updateCategoryName(newCategoryName: newName);
        return;
      }
    }
  }

  /// Updates the budget variables for the `"Discretionary"` [FinanceCategory]
  /// object contained within [_listOfCategories]. Update the [_budgetRemaining]
  /// of the current [FinancePage] object to be equal to [newBudget]. Lastly,
  /// update the [_totalBudget] of the [FinanceCategory] to be the passed [newBudget].
  void updateBudgetForDiscretionary({required double newBudget}) {
    _budgetRemaining = newBudget;
    _listOfCategories[_listOfCategories.length - 1]
        .updateBudget(newBudget: newBudget);
  }

  /// Returns the total budget
  double getTotalBudget() {
    return _totalBudget;
  }

  /// Returns the budget allocated
  double getBudgetSpent() {
    return _budgetSpent;
  }

  /// Returns the amount of unallocated budget
  double getBudgetRemaining() {
    return _budgetRemaining;
  }

  /// Returns the list of [FinanceCategory] objects
  List<FinanceCategory> getFinanceCategories() {
    return _listOfCategories;
  }

  /// Converts the current [FinancePage] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "totalBudget": _totalBudget,
      "budgetSpent": _budgetSpent,
      "budgetRemaining": _budgetRemaining,
      "financeCategories": _listOfCategories
          .map((financeCategory) => financeCategory.toJson())
          .toList()
    };
  }
}
