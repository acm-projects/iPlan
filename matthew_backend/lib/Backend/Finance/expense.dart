/// @author [MatthewSheldon]
/// The [Expense] object represents an individual expense contained
/// within a [FinanceCategory] object
class Expense {
  /// The name of the expense item
  late String _expenseName;

  /// The amount of money allocated for the expense item
  late double _budgetForExpense;

  /// Constructs an Expense object with parameters [name] and [budget]
  Expense({required String name, required double budget}) {
    _expenseName = name;
    _budgetForExpense = budget;
  }

  /// Constructs an [Expense]] object from the passed [json] file
  Expense.fromJson({required Map<String, dynamic> json}) {
    _expenseName = json["expenseName"];
    _budgetForExpense = json["budgetForExpense"];
  }

  /// Returns the title given to the current expense
  String getExpenseName() {
    return _expenseName;
  }

  /// Returns the amount of money spent on the current expense
  double getExpenseBudget() {
    return _budgetForExpense;
  }

  /// Converts the current [Expense] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "expenseName": _expenseName,
      "budgetForExpense": _budgetForExpense
    };
  }
}