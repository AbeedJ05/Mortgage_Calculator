import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MortgageCalculatorApp());
}

class MortgageCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MortgageCalculator(),
    );
  }
}

class MortgageCalculator extends StatefulWidget {
  @override
  _MortgageCalculatorState createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _downPaymentController = TextEditingController();
  final TextEditingController _repaymentTimeController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();

  double get loanAmount {
    double purchasePrice = double.tryParse(_purchasePriceController.text) ?? 0;
    double downPayment = double.tryParse(_downPaymentController.text) ?? 0;
    return purchasePrice - downPayment;
  }

  double calculateMonthlyPayment() {
    double purchasePrice = double.tryParse(_purchasePriceController.text) ?? 0;
    double downPayment = double.tryParse(_downPaymentController.text) ?? 0;
    double repaymentTime = double.tryParse(_repaymentTimeController.text) ?? 1;
    double interestRate = double.tryParse(_interestRateController.text) ?? 0;

    double loanAmount = purchasePrice - downPayment;
    double monthlyInterestRate = interestRate / 100 / 12;
    double numberOfPayments = repaymentTime * 12;

    if (monthlyInterestRate == 0) {
      return loanAmount / numberOfPayments;
    }

    return loanAmount *
        monthlyInterestRate /
        (1 - pow(1 + monthlyInterestRate, -numberOfPayments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Mortgage Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _purchasePriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Purchase Price',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _downPaymentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Down Payment',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _repaymentTimeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Repayment Time (years)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _interestRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Interest Rate (%)',
                suffixText: '%',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Loan amount: \$${loanAmount.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Estimated per month: \$${calculateMonthlyPayment().toStringAsFixed(0)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Update the calculation when the button is pressed.
                  });
                },
                child: Text('Get a mortgage quote'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  backgroundColor: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _purchasePriceController.dispose();
    _downPaymentController.dispose();
    _repaymentTimeController.dispose();
    _interestRateController.dispose();
    super.dispose();
  }
}
