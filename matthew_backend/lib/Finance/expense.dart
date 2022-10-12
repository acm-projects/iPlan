/// The [Expense] object represents an individual expense contained
/// within a [FinanceCategory] object
class Expense {
  /// The name of the expense item
  late String _expenseName;
  /// The amount of money allocated for the expense item
  late double _budgetForExpense;

  /// Constructs an Expense object with parameters [name] and [budget]
  Expense(String name, double budget) {
    _expenseName = name;
    _budgetForExpense = budget;
  }

  /// Returns the title given to the current expense
  String getExpenseName() {
    return _expenseName;
  }

  /// Returns the amount of money spent on the current expense
  double getExpenseBudget() {
    return _budgetForExpense;
  }
}