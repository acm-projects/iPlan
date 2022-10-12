import 'expense.dart';

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
  /// The list of the individual expenses for the category
  late List<Expense> _listOfExpenses;

  /// Creates a [FinanceCategory] Object with parameters [name] and [budget]
  FinanceCategory(String name, double budget) {
    _categoryName = name;
    _totalBudget = budget;
    _budgetRemaining = budget;
  }

  /// Inserts the passed [newExpense] item into the [listOfExpenses] in order
  /// with respect to alphabetic order. Additionally, update the [budgetUsed] and [budgetRemaining]
  void addItem(Expense newExpense) {
    all: for(int i = 0; i < _listOfExpenses.length; i++) {
      if(_listOfExpenses[i].getExpenseName().compareTo(newExpense.getExpenseName()) > 0) {
        _listOfExpenses.insert(i, newExpense);
        _budgetUsed += newExpense.getExpenseBudget();
        _budgetRemaining = _totalBudget - _budgetUsed;
        break all;
      }
    }
  }

  /// Removes the passed [expenseToRemove] from this [FinanceCategory]'s [listOfExpenses].
  /// Additionally, update the [budgetUsed] and [budgetRemaining]
  void removeItem(Expense expenseToRemove) {
    _listOfExpenses.remove(expenseToRemove);
    _budgetUsed -= expenseToRemove.getExpenseBudget();
    _budgetRemaining = _totalBudget - _budgetUsed;
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

  /// Returns this [FinanceCategory] object's list of [Expense] objects
  List<Expense> getListOfExpenses() {
    return _listOfExpenses;
  }
}