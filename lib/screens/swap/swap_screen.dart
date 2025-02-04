import 'package:flutter/material.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  String fromCurrency = "USD";
  String toCurrency = "ETH";

  final List<Map<String, String>> currencies = [
    {"symbol": "USD", "description": "United States Dollar"},
    {"symbol": "EUR", "description": "Euro"},
    {"symbol": "BTC", "description": "Bitcoin"},
    {"symbol": "ETH", "description": "Ethereum"},
    {"symbol": "JPY", "description": "Japanese Yen"},
    {"symbol": "GBP", "description": "British Pound"},
  ];

  String selectedCurrency = "";

  // Controllers for TextFields
  final TextEditingController _fromAmountController = TextEditingController();
  final TextEditingController _toAmountController = TextEditingController();

  @override
  void dispose() {
    _fromAmountController.dispose();
    _toAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Swap Token",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "FANTOM OPERA",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildTokenCard(
                    context,
                    "Enter Amount",
                    fromCurrency,
                    _fromAmountController,
                    'From',
                  ),
                  const SizedBox(height: 20),
                  _buildTokenCard(
                    context,
                    "Converted Amount",
                    toCurrency,
                    _toAmountController,
                    'Receive',
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _performSwap();
                      },
                      child: const Text(
                        "Swap now",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              left: 50,
              right: 50,
              top: 180,
              child: Center(
                child: GestureDetector(
                  onTap: _performSwap,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_vert,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenCard(BuildContext context, String title, String token,
      TextEditingController controller, String where,
      {bool readOnly = false}) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xffEAF2F9),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          width: 1.5,
          color: const Color.fromARGB(255, 209, 231, 250),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  where,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        _openCurrencySelector(
                            context, where == 'From' ? 'from' : 'to');
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_drop_down, size: 24),
                          Text(
                            token,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                decoration: InputDecoration(
                  hintText: title,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performSwap() {
    final double? amount = double.tryParse(_fromAmountController.text);

    if (amount == null || fromCurrency == toCurrency) {
      _toAmountController.text = "0";
      return;
    }

    double rate = _getConversionRate(fromCurrency, toCurrency);

    // Check if the rate is available
    if (rate == 1.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Conversion rate not available for $fromCurrency to $toCurrency.'),
          backgroundColor: Colors.red,
        ),
      );
      _toAmountController.text = "0";
      return;
    }

    double result = amount * rate;

    setState(() {
      _toAmountController.text = result.toStringAsFixed(2);
    });
  }

  double _getConversionRate(String from, String to) {
    // Updated conversion rates including JPY
    Map<String, Map<String, double>> rates = {
      "ETH": {
        "USD": 3000,
        "BTC": 0.07,
        "EUR": 2800,
        "JPY": 450000,
        "GBP": 2400
      },
      "BTC": {
        "USD": 45000,
        "ETH": 14,
        "EUR": 42000,
        "JPY": 6700000,
        "GBP": 38000
      },
      "USD": {
        "ETH": 0.00033,
        "BTC": 0.000022,
        "EUR": 0.93,
        "JPY": 150,
        "GBP": 0.76
      },
      "EUR": {
        "USD": 1.08,
        "ETH": 0.00036,
        "BTC": 0.000024,
        "JPY": 162,
        "GBP": 0.82
      },
      "JPY": {
        "USD": 0.0067,
        "ETH": 0.0000022,
        "BTC": 0.00000015,
        "EUR": 0.0062,
        "GBP": 0.005
      },
      "GBP": {
        "USD": 1.32,
        "ETH": 0.00042,
        "BTC": 0.000026,
        "EUR": 1.22,
        "JPY": 200
      },
    };

    // Return the conversion rate or 1.0 if not found
    return rates[from]?[to] ?? 1.0;
  }

  void _openCurrencySelector(BuildContext context, String target) {
    setState(() {
      selectedCurrency = target == 'from' ? fromCurrency : toCurrency;
    });

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                ),
                itemCount: currencies.length,
                itemBuilder: (context, index) {
                  String currency = currencies[index]["symbol"]!;
                  String description = currencies[index]["description"]!;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (target == 'from') {
                          fromCurrency = currency;
                        } else {
                          toCurrency = currency;
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedCurrency == currency
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: selectedCurrency == currency ? 2 : 1.5,
                            ),
                            color: selectedCurrency == currency
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.white,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currency,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: selectedCurrency == currency
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  description,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
