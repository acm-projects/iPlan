import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Backend/Authentication/update_files.dart';
import '../../Backend/User_Creation/user.dart';
import '../../Backend/Event_Manager/event.dart';
import '../../Backend/Finance/expense.dart';
import '../../Backend/Finance/finance_category.dart';
import '../../Backend/Finance/finance_page.dart';

/// @author [MatthewSheldon]
/// The [User] object that will be updated
late User _user;

/// @author [MatthewSheldon]
/// The [Event] object for the current event that will be updated
late Event _event;

/// @author [MatthewSheldon]
/// The [FinancePage] object for the current [Event] object that will be updated
late FinancePage _financePage;

/// @author [MatthewSheldon]
/// The list of [FinanceCategory] objects for the current [Event] object
late List<FinanceCategory> _budgetList;

/// @author [JenniferZhang]
/// The total budget of the current event
late double _totalBudget;

/// @author [JenniferZhang]
/// The amount of the total budget that has been spent
late double _budgetSpent;

/// @author [MatthewSheldon]
/// The amount of the total budget that has not been allocated
late double _budgetRemaining;

/// @author [JenniferZhang]
/// The percent of the budget that has been used
late double _percent;

int colorsIndex = 0;

/// @author [MatthewSheldon]
/// Used to update the [Event] object in the cloud
void _updateEventObject() async {
  _event.updateFinancePage(financePage: _financePage);
  _user.updateEvent(eventID: _event.getLink(), event: _event);
  await UpdateFiles.updateEventFile(
      documentID: _event.getLink(), json: _event.toJson());
}

/// @author [JenniferZhang]
void _updateBudgetVals() {
  /// @author [MatthewSheldon] updated the variables used to be the Backend
  /// equivalent of what [JenniferZhang] had been using
  _totalBudget = _financePage.getTotalBudget();
  _budgetSpent = _financePage.getBudgetSpent();
  _budgetRemaining = _financePage.getBudgetRemaining();
  _financePage.updateBudgetForDiscretionary(newBudget: _budgetRemaining);
  _percent = (_budgetSpent / _totalBudget) * 100;
  _budgetList = _financePage.getFinanceCategories();
}

class Budget extends StatefulWidget {
  /// @author [MatthewSheldon]
  /// Constructs a [Budget] page with the [User] object and [Event] object
  /// defined by the passed [user] and [event] paramaters
  Budget({super.key, required User user, required Event event}) {
    _user = user;
    _event = event;
    _financePage = _event.getFinancePage();
    _updateBudgetVals();
  }

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  List<Color> colors = [
    Color(0xFF8E65E3),
    Color(0xFFE38E65),
    Color(0xFF65E38E),
    Color(0xFF65BAE3),
    Color(0xFFE3CD65),
    Color(0xFFE3657B),
    Color(0xFF65E3CD),
    Color(0xFFFFA500)
  ];

  late TooltipBehavior _tooltipBehavior;
  var f = NumberFormat("\$###,##0.00");

  TextEditingController _expenseController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _categoryBudgetController = TextEditingController();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _updateBudgetVals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF657BE3),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 5.0),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: 'Budget',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color.fromRGBO(254, 247, 236, 1),
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 9.0, 0.0, 0.0),
              child: Container(
                height: size.height - 184.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFEF7EC),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Remaining Budget',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          f.format(_budgetRemaining),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(children: [
                              Text(
                                'Total Budget',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                f.format(_totalBudget),
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(width: 30),
                            Column(children: [
                              Text(
                                'Spent Budget',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                f.format(_budgetSpent),
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                        SizedBox(height: 40),
                        SfCircularChart(
                            annotations: <CircularChartAnnotation>[
                              CircularChartAnnotation(
                                widget: Container(
                                  child: Text(
                                    _percent.toStringAsFixed(2) + '%',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            tooltipBehavior: _tooltipBehavior,
                            series: <CircularSeries>[
                              DoughnutSeries<FinanceCategory, String>(
                                dataSource: _budgetList,
                                pointColorMapper: (FinanceCategory data, _) =>
                                    data.getColor(),
                                xValueMapper: (FinanceCategory data, _) =>
                                    data.getCategoryName(),
                                yValueMapper: (FinanceCategory data, _) =>
                                    data.getTotalBudget(),
                                innerRadius: '70%',
                                radius: '90%',
                                sortingOrder: SortingOrder.none,
                                explode: true,
                                dataLabelMapper: (FinanceCategory data, _) =>
                                    data.getCategoryName(),
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    labelPosition:
                                        ChartDataLabelPosition.outside),
                                enableTooltip: true,
                              )
                            ]),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Categories",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    for (var i = 0; i < _budgetList.length - 1; i++)
                      (Column(
                        children: [
                          budgetCategory(_budgetList[i]),
                        ],
                      )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Container(
                                  color: Color(0xff757575),
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(101, 123, 227, 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                size: 40.0,
                                                Icons.close,
                                              ),
                                              color: Color.fromRGBO(
                                                  186, 227, 101, 1),
                                              onPressed: () {
                                                _categoryController.clear();
                                                _categoryBudgetController
                                                    .clear();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Add Category",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30.0,
                                                color: Color.fromRGBO(
                                                    254, 247, 236, 1),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            IconButton(
                                              icon: const Icon(
                                                size: 40.0,
                                                Icons.check_circle,
                                              ),
                                              color: Color.fromRGBO(
                                                  186, 227, 101, 1),
                                              onPressed: () {
                                                if (isAmountValid(
                                                    _categoryBudgetController)) {
                                                  if (!(_categoryController
                                                          .text.isEmpty ||
                                                      _categoryBudgetController
                                                          .text.isEmpty)) {
                                                    /// @author [MatthewSheldon] changed from updating the
                                                    _financePage.addCategory(
                                                        categoryName:
                                                            _categoryController
                                                                .text,
                                                        budget: double.parse(
                                                            _categoryBudgetController
                                                                .text),
                                                        color: colors[
                                                            colorsIndex]);

                                                    /// end @author [MatthewSheldon]
                                                  }
                                                  print("Before $colorsIndex");
                                                  if (colorsIndex < 7) {
                                                    colorsIndex++;
                                                  } else {
                                                    colorsIndex = 0;
                                                  }
                                                  print("After $colorsIndex");

                                                  /// @author [MatthewSheldon]
                                                  _updateBudgetVals();
                                                  _updateEventObject();

                                                  /// end @author [MatthewSheldon]
                                                  Navigator.pop(context);
                                                  _categoryController.clear();
                                                }
                                                _categoryBudgetController
                                                    .clear();
                                                setState(() {});
                                                return;
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 25),
                                        //category name
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                254, 247, 236, 1),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: TextField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    10),
                                              ],
                                              controller: _categoryController,
                                              style: GoogleFonts.lato(
                                                color: Colors.black,
                                              ),
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Category Name',
                                                prefixIcon: Icon(
                                                  Icons.category,
                                                  color: Color(0xFF657BE3),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        //budget amount
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                254, 247, 236, 1),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: TextField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    10),
                                              ],
                                              controller:
                                                  _categoryBudgetController,
                                              style: GoogleFonts.lato(
                                                color: Colors.black,
                                              ),
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Budget Amount',
                                                prefixIcon: Icon(
                                                  Icons.attach_money,
                                                  color: Color(0xFF657BE3),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        label: Text(
                          "Add Category",
                          style: GoogleFonts.lato(),
                        ),
                        icon: Icon(Icons.add),
                        backgroundColor: Color(0xFFBAE365),
                        foregroundColor: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    //delete button
                    if (_budgetList.length > 1) ...[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Container(
                                    color: Color(0xff757575),
                                    child: Container(
                                      padding: EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(101, 123, 227, 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  size: 40.0,
                                                  Icons.close,
                                                ),
                                                color: Color.fromRGBO(
                                                    186, 227, 101, 1),
                                                onPressed: () {
                                                  _categoryController.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Delete Category",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Color.fromRGBO(
                                                      254, 247, 236, 1),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              IconButton(
                                                icon: const Icon(
                                                  size: 40.0,
                                                  Icons.check_circle,
                                                ),
                                                color: Color.fromRGBO(
                                                    186, 227, 101, 1),
                                                onPressed: () {
                                                  if (isCategoryValid(
                                                      _categoryController)) {
                                                    /// @author [MatthewSheldon]
                                                    _financePage.removeCategory(
                                                        categoryName:
                                                            _categoryController
                                                                .text);
                                                    _updateBudgetVals();
                                                    _updateEventObject();

                                                    /// end @author [MatthewSheldon]
                                                    Navigator.pop(context);
                                                  }
                                                  _categoryController.clear();
                                                  setState(() {});
                                                  return;
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 25),
                                          //expense name
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  254, 247, 236, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: TextField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      20),
                                                ],
                                                controller: _categoryController,
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                ),
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Category name',
                                                  prefixIcon: Icon(
                                                    Icons.category,
                                                    color: Color(0xFF657BE3),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          label: Text(
                            "Delete Category",
                            style: GoogleFonts.lato(),
                          ),
                          icon: Icon(Icons.delete),
                          backgroundColor: Color(0xFFBAE365),
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget budgetCategory(FinanceCategory category) {
    List<Expense> expenses = category.getListOfExpenses();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: category.getColor(),
            width: 5.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: ExpansionTile(
          initiallyExpanded: false,
          title: SizedBox(
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  decoration: BoxDecoration(
                    color: category.getColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        expenses.length.toString(),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(254, 247, 236, 1),
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'expenses',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(254, 247, 236, 1),
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      category.getCategoryName(),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Remaining Budget',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Total Budget',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Spent Budget',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.format(category.getBudgetRemaining()),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: ((category.getBudgetRemaining()) > 0)
                                      ? Colors.black
                                      : Colors.red,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              f.format(category.getTotalBudget()),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              f.format(category.getBudgetUsedOnCategory()),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          tilePadding: EdgeInsets.all(15.0),
          children: [
            SizedBox(height: 10),
            Divider(
              color: category.getColor(),
              thickness: 5,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '    Expenses',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            expensesList(category),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Container(
                            color: Color(0xff757575),
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(101, 123, 227, 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          size: 40.0,
                                          Icons.close,
                                        ),
                                        color: Color.fromRGBO(186, 227, 101, 1),
                                        onPressed: () {
                                          _expenseController.clear();
                                          _amountController.clear();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Add Expense",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0,
                                          color:
                                              Color.fromRGBO(254, 247, 236, 1),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      IconButton(
                                        icon: const Icon(
                                          size: 40.0,
                                          Icons.check_circle,
                                        ),
                                        color: Color.fromRGBO(186, 227, 101, 1),
                                        onPressed: () {
                                          if (!(_expenseController
                                                  .text.isEmpty ||
                                              _amountController.text.isEmpty)) {
                                            /// @author [MatthewSheldon]
                                            _financePage.addExpenseToCategory(
                                                categoryName:
                                                    category.getCategoryName(),
                                                expenseName:
                                                    _expenseController.text,
                                                expenseBudget: double.parse(
                                                    _amountController.text));
                                          }
                                          _updateBudgetVals();
                                          _updateEventObject();

                                          /// end @author [MatthewSheldon]
                                          Navigator.pop(context);
                                          _expenseController.clear();
                                          _amountController.clear();
                                          setState(() {});
                                          return;
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  //expense name
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(254, 247, 236, 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: TextField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(20),
                                        ],
                                        controller: _expenseController,
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Expense Name',
                                          prefixIcon: Icon(
                                            Icons.add_shopping_cart,
                                            color: Color(0xFF657BE3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  //expense amount
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(254, 247, 236, 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        controller: _amountController,
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Expense Amount',
                                          prefixIcon: Icon(
                                            Icons.attach_money,
                                            color: Color(0xFF657BE3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  label: Text(
                    "Add Expense",
                    style: GoogleFonts.lato(),
                  ),
                  icon: Icon(Icons.add),
                  backgroundColor: category.getColor(),
                  foregroundColor: Color(0xFFFEF7EC),
                ),
                SizedBox(width: 25),
                FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Container(
                            color: Color(0xff757575),
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(101, 123, 227, 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          size: 40.0,
                                          Icons.close,
                                        ),
                                        color: Color.fromRGBO(186, 227, 101, 1),
                                        onPressed: () {
                                          _categoryController.clear();
                                          _categoryBudgetController.clear();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Edit Category",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0,
                                          color:
                                              Color.fromRGBO(254, 247, 236, 1),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      IconButton(
                                        icon: const Icon(
                                          size: 40.0,
                                          Icons.check_circle,
                                        ),
                                        color: Color.fromRGBO(186, 227, 101, 1),
                                        onPressed: () {
                                          //TODO: edits category name and/or budget
                                          if (_categoryController
                                              .text.isNotEmpty) {
                                            /// @author [MatthewSheldon]
                                            _financePage.updateCategoryName(
                                                oldName:
                                                    category.getCategoryName(),
                                                newName:
                                                    _categoryController.text);

                                            /// end @author [MatthewSheldon]
                                          }
                                          if (_categoryBudgetController
                                              .text.isNotEmpty) {
                                            if (isAmountValid(
                                                _categoryBudgetController)) {
                                              /// @author [MatthewSheldon]
                                              _financePage.updateBudgetForCategory(
                                                  categoryName: category
                                                      .getCategoryName(),
                                                  newBudget: double.parse(
                                                      _categoryBudgetController
                                                          .text));
                                              _updateBudgetVals();
                                            }
                                          }
                                          _updateEventObject();

                                          /// end @author [MatthewSheldon]
                                          Navigator.pop(context);
                                          _categoryController.clear();
                                          _categoryBudgetController.clear();
                                          setState(() {});
                                          return;
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  //category name
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(254, 247, 236, 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: TextField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        controller: _categoryController,
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Edit Category Name',
                                          prefixIcon: Icon(
                                            Icons.category,
                                            color: Color(0xFF657BE3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  //budget amount
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(254, 247, 236, 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: TextField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        controller: _categoryBudgetController,
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                        ),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Edit Budget Amount',
                                          prefixIcon: Icon(
                                            Icons.attach_money,
                                            color: Color(0xFF657BE3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  label: Text(
                    "Edit Category",
                    style: GoogleFonts.lato(),
                  ),
                  icon: Icon(Icons.edit),
                  backgroundColor: category.getColor(),
                  foregroundColor: Color.fromRGBO(254, 247, 236, 1),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget expensesList(FinanceCategory category) {
    List<Expense> expenses = category
        .getListOfExpenses(); // @author [MatthewSheldon] added the list of [Expense] objects
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < expenses.length; i++)
                (Column(
                  children: [
                    Text(
                      expenses[i].getExpenseName().padRight(20, '   '), // @author [MatthewSheldon] get the name of the [Expense] object
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )),
            ],
          ),
          SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < expenses.length; i++)
                (Column(
                  children: [
                    Text(
                      f.format(expenses[i]
                          .getExpenseBudget()), // @author [MatthewSheldon] get the budget allocated to the [Expense] object and format it
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ))
            ],
          ),
        ],
      ),
    );
  }

  bool isAmountValid(TextEditingController controller) {
    return double.parse(controller.text) <= _budgetRemaining;
  }

  bool isCategoryValid(TextEditingController controller) {
    for (var i = 0; i < _budgetList.length; i++) {
      if (_budgetList[i].getCategoryName() == controller.text) {
        // @author [MatthewSheldon] changed it to refer to the [FinanceCategory] object
        return true;
      }
    }
    return false;
  }

  FinanceCategory getCategory(TextEditingController controller) {
    for (var i = 0; i < _budgetList.length; i++) {
      if (_budgetList[i].getCategoryName() == controller.text) {
        // @author [MatthewSheldon] changed it to refer to the [FinanceCategory] object
        return _budgetList[i];
      }
    }
    return _budgetList[0];
  }
}