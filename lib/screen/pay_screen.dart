import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sushi_mobile_app/providers/cart.dart';
import 'package:sushi_mobile_app/screen/home_screen.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String? _selectedPaymentMethod;
  String _virtualAccountNumber = '';

  @override
  void initState() {
    super.initState();
  }

  void _generateVA() {
    final random = Random();
    _virtualAccountNumber = List.generate(10, (_) => random.nextInt(10)).join();
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _virtualAccountNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Virtual Account Number copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          double totalPrice = 0;
          int totalItems = 0;
          for (var item in cart.cart) {
            int quantity = int.tryParse(item.quantity ?? '0') ?? 0;
            double price = double.tryParse(item.price ?? '0') ?? 0.0;
            totalPrice += quantity * price;
            totalItems += quantity;
          }
          double taxAndService = totalPrice * 0.11;
          double totalPayment = totalPrice + taxAndService;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                _buildSummaryRow('Total Items:', '$totalItems'),
                _buildSummaryRow(
                    'Total Price:', 'IDR ${totalPrice.toStringAsFixed(2)}'),
                _buildSummaryRow('Tax and Service:',
                    'IDR ${taxAndService.toStringAsFixed(2)}'),
                Divider(),
                _buildSummaryRowWithRedBackground(
                  'Total Payment:',
                  'IDR ${totalPayment.toStringAsFixed(2)}',
                  isBold: true,
                ),
                SizedBox(height: 20),
                Text(
                  'Choose Payment Method',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                ListTile(
                  title: const Text('E-Wallet'),
                  leading: Radio<String>(
                    value: 'E-Wallet',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                        _generateVA();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Bank Transfer'),
                  leading: Radio<String>(
                    value: 'Bank Transfer',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                        _generateVA();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Apple Pay'),
                  leading: Radio<String>(
                    value: 'Apple Pay',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                        _generateVA();
                      });
                    },
                  ),
                ),
                if (_selectedPaymentMethod != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Virtual Account Number: $_virtualAccountNumber',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.copy),
                            onPressed: _copyToClipboard,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            cart.clearCart();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    accountNumber: _virtualAccountNumber),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8C5E5B),
                            padding: EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: Text(
                            'Checkout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRowWithRedBackground(String label, String value,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
