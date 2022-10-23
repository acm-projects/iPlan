import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  List<Color> colors = [Color(0xFF8E65E3), Color(0xFFE38E65), Color(0xFF65E38E), Color(0xFF65BAE3), Color(0xFFE3CD65), Color(0xFFE3657B), Color(0xFF65E3CD), Color(0xFFFFA500)];
  int colorsIndex = 0;

  late List<BudgetData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  var f = NumberFormat("\$###,##0.00");
  double budget = 12000;
  late double spent;
  late double percent;

  TextEditingController _expenseController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _categoryBudgetController = TextEditingController();


  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(enable: true);
    _chartData = getChartData();
    updateBudgetVals();
    super.initState();
  }

  void updateBudgetVals(){
    spent = 0;
    for (var i = 0; i < _chartData.length - 1; i++) {
      spent += _chartData[i].budget;
    }
    _chartData[_chartData.length - 1].budget = budget - spent;
    percent = spent / budget * 100;
  }

  void updateExpenseVals(BudgetData category){
    double tempSpent = 0;
    for (var i = 0; i < category.expenses.length; i++) {
      tempSpent += category.expenses[i].amount;
    }
    category.moneySpent = tempSpent;
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
                  children:[
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
                          f.format(budget - spent),
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
                            Column(
                              children: [
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
                                  f.format(budget),
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]
                            ),
                            SizedBox(width: 30),
                            Column(
                              children: [
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
                                  f.format(spent),
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        SfCircularChart(
                          annotations: <CircularChartAnnotation>[
                            CircularChartAnnotation(
                              widget: Container(
                                child: Text(
                                  percent.toStringAsFixed(2) + '%',
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
                            DoughnutSeries<BudgetData, String>(
                              dataSource: _chartData,
                              pointColorMapper: (BudgetData data,_) => data.color,
                              xValueMapper: (BudgetData data,_) => data.category,
                              yValueMapper: (BudgetData data,_) => data.budget,
                              innerRadius: '70%',
                              radius: '90%',
                              sortingOrder: SortingOrder.none,
                              explode: true,
                              dataLabelMapper: (BudgetData data,_) => data.category,
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  labelPosition: ChartDataLabelPosition.outside
                              ),
                              enableTooltip: true,
                            )
                          ]
                        ),
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
                    for(var i = 0; i < _chartData.length - 1; i++)(
                      Column(
                        children: [
                          budgetCategory(_chartData[i]),
                        ],
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FloatingActionButton.extended(
                        onPressed: (){
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
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                size: 40.0,
                                                Icons.close,
                                              ),
                                              color: Color.fromRGBO(186, 227, 101, 1),
                                              onPressed: (){
                                                _categoryController.clear();
                                                _categoryBudgetController.clear();
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
                                                color: Color.fromRGBO(254, 247, 236, 1),
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
                                                if (isAmountValid(_categoryBudgetController)){
                                                  if (!(_categoryController.text.isEmpty || _categoryBudgetController.text.isEmpty)) {
                                                    _chartData.insert(_chartData.length - 1, new BudgetData(_categoryController.text, double.parse(_categoryBudgetController.text), colors[colorsIndex]));
                                                  }
                                                  if (colorsIndex < 7){
                                                    colorsIndex++;
                                                  }
                                                  else{
                                                    colorsIndex = 0;
                                                  }
                                                  updateBudgetVals();
                                                  Navigator.pop(context);
                                                  _categoryController.clear();
                                                }
                                                _categoryBudgetController.clear();
                                                setState((){});
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
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: TextField(
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
                                            color: Color.fromRGBO(254, 247, 236, 1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: TextField(
                                              controller: _categoryBudgetController,
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
                    if (_chartData.length > 1) ...[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FloatingActionButton.extended(
                          onPressed: (){
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
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  size: 40.0,
                                                  Icons.close,
                                                ),
                                                color: Color.fromRGBO(186, 227, 101, 1),
                                                onPressed: (){
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
                                                  color: Color.fromRGBO(254, 247, 236, 1),
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
                                                  if (isCategoryValid(_categoryController)){
                                                    _chartData.remove(getCategory(_categoryController));
                                                    updateBudgetVals();
                                                    Navigator.pop(context);
                                                  }
                                                  _categoryController.clear();
                                                  setState((){});
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
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: TextField(
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
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      //Navigation Bar with Icons
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black, size: 30), label: 'Home', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month, color: Colors.black, size: 30), label: 'Calendar', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.wallet, color: Colors.black, size: 30), label: 'Budget', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.schedule, color: Colors.black, size: 30), label: 'Itinerary', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.person_add, color: Colors.black, size: 30), label: 'Collaborate', backgroundColor: Color(0xFFA3B0EB)),
            BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.black, size: 30), label: 'Settings', backgroundColor: Color(0xFFA3B0EB))
          ]
      ),
    );
  }

  List<BudgetData> getChartData(){
    List<BudgetData> chartData = [
      BudgetData('Discretionary', 0, Color(0xFFE7E7E7))
    ];
    return chartData;
  }

  Widget budgetCategory(BudgetData category){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: category.color,
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
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
                  decoration: BoxDecoration(
                    color: category.color,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children:[
                      SizedBox(height: 10),
                      Text(
                        category.expenses.length.toString(),
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
                  children:[
                    Text(
                      category.category,
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
                      children:[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
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
                        SizedBox(width: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(
                              f.format(category.budget - category.moneySpent),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: ((category.budget - category.moneySpent) > 0) ? Colors.black : Colors.red,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              f.format(category.budget),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              f.format(category.moneySpent),
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
              color: category.color,
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
            FloatingActionButton.extended(
              onPressed: (){
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      size: 40.0,
                                      Icons.close,
                                    ),
                                    color: Color.fromRGBO(186, 227, 101, 1),
                                    onPressed: (){
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
                                      color: Color.fromRGBO(254, 247, 236, 1),
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
                                      if (!(_expenseController.text.isEmpty || _amountController.text.isEmpty)) {
                                        category.expenses.add(new Expense(_expenseController.text, double.parse(_amountController.text)));
                                      }
                                      updateExpenseVals(category);
                                      Navigator.pop(context);
                                      _expenseController.clear();
                                      _amountController.clear();
                                      setState((){});
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
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextField(
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
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
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
              backgroundColor: category.color,
              foregroundColor: Color(0xFFFEF7EC),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget expensesList(BudgetData category){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children:[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              for(var i = 0; i < category.expenses.length; i++)(
                Column(
                  children:[
                    Text(
                      category.expenses[i].name,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ),
            ],
          ),
          SizedBox(width: 180),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              for(var i = 0; i < category.expenses.length; i++)(
                Column(
                  children:[
                    Text(
                      f.format(category.expenses[i].amount),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              )
            ],
          ),
        ],
      ),
    );
  }

  bool isAmountValid(TextEditingController controller){
    return double.parse(controller.text) <= budget - spent;
  }

  bool isCategoryValid(TextEditingController controller){
    for (var i = 0; i < _chartData.length; i++){
      if (_chartData[i].category == controller.text){
        return true;
      }
    }
    return false;
  }

  BudgetData getCategory(TextEditingController controller){
    for (var i = 0; i < _chartData.length; i++){
      if (_chartData[i].category == controller.text){
        return _chartData[i];
      }
    }
    return _chartData[0];
  }
}

class BudgetData{
  BudgetData(this.category, this.budget, this.color);
  String category;
  double budget;
  Color color;
  double moneySpent = 0;
  List<Expense> expenses = [];
}

class Expense{
  Expense(this.name, this.amount);
  String name;
  double amount;
}