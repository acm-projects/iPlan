import 'expense.dart';

/// @author [MatthewSheldon]
/// The [FinanceCategory] object represents an entire group of Expense objects
/// with a common theme. This is used in tandem with the [FinancePage] class.
class FinanceCategory implements Comparable<FinanceCategory> {
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
  FinanceCategory({required String name, required double budget}) {
    _categoryName = name;
    _totalBudget = budget;
    _budgetRemaining = budget;
  }

  /// Constructs a [FinanceCategory] object from the passed [json] file
  FinanceCategory.fromJson({required Map<String, dynamic> json}) {
    _categoryName = json["categoryName"];
    _budgetRemaining = json["budgetRemaining"];
    _budgetUsed = json["budgetUsed"];
    _totalBudget = json["totalBudget"];
    List<dynamic> expensesData = json["expenses"] as List<dynamic>;
    _listOfExpenses =
        expensesData.map((expense) => Expense.fromJson(json: expense)).toList();
  }

  /// Inserts the passed [newExpense] item into the [_listOfExpenses] in order
  /// with respect to alphabetic order. Additionally, update the [_budgetUsed] 
  /// and [_budgetRemaining]
  void addItem({required Expense newExpense}) {
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
    _listOfExpenses.add(newExpense);
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

  /// Returns this [FinanceCategory] object's list of [Expense] objects
  List<Expense> getListOfExpenses() {
    return _listOfExpenses;
  }

  /// Converts the current [FinanceCategory] object into a json file formatted [Map]
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "categoryName": _categoryName,
      "budgetRemaining": _budgetRemaining,
      "budgetUsed": _budgetUsed,
      "totalBudget": _totalBudget,
      "expenses": _listOfExpenses.map((expense) => expense.toJson()).toList()
    };
  }

  @override
  int compareTo(FinanceCategory other) {
    return _categoryName.compareTo(other.getCategoryName());
  }
}
