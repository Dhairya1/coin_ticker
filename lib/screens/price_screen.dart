import 'package:bitcoin_ticker/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String fetchedRateFirst = '?';
  String fetchedRateSecond = '?';
  String fetchedRateThird = '?';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String item in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(item), value: item);
      dropDownItems.add(newItem);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          fetchedRateFirst = '?';
          fetchedRateSecond = '?';
          fetchedRateThird = '?';
          selectedCurrency = value!;
          makeAPICallFor(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String item in currenciesList) {
      pickerItems.add(
        Text(
          item,
          style: whiteTextStyle,
        ),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          fetchedRateFirst = '?';
          fetchedRateSecond = '?';
          fetchedRateThird = '?';
          makeAPICallFor(currenciesList[selectedIndex]);
        });
      },
      children: pickerItems,
    );
  }

  void makeAPICallFor(String exchangeCurrency) async {
    List<dynamic> conversionData =
        await CoinData().getConversionRateFor(exchangeCurrency);
    setState(() {
      double firstRate = conversionData.first['rate'];
      fetchedRateFirst = firstRate.toStringAsFixed(0);

      double secRate = conversionData[1]['rate'];
      fetchedRateSecond = secRate.toStringAsFixed(0);

      double thirdRate = conversionData.last['rate'];
      fetchedRateThird = thirdRate.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: CurrencyDisplayLabel(initialCurrency: 'BTC', toCurrency: selectedCurrency, conversionRate: fetchedRateFirst,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: CurrencyDisplayLabel(
                      initialCurrency: 'ETH',
                      toCurrency: selectedCurrency,
                      conversionRate: fetchedRateFirst,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: CurrencyDisplayLabel(
                        initialCurrency: 'LTC',
                        toCurrency: selectedCurrency,
                        conversionRate: fetchedRateFirst,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

const whiteTextStyle = TextStyle(
  color: Colors.white,
);

class CurrencyDisplayLabel extends StatelessWidget {
  const CurrencyDisplayLabel({
    Key? key,
    required this.initialCurrency,
    required this.toCurrency,
    required this.conversionRate
  }): super(key: key);

  final String initialCurrency;
  final String toCurrency;
  final String conversionRate;

  @override
  Widget build(BuildContext context) {
    return Text(
      '1 $initialCurrency = $conversionRate $toCurrency',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }
}
