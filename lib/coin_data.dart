import 'package:bitcoin_ticker/services/networking.dart';
import 'package:bitcoin_ticker/constants/constants.dart';

class CoinData {
  Future<dynamic> getConversionRateFor(String currency) async {
    List arrayURL = [
      (conversionURL + 'BTC'+'/$currency' + '?apikey=$apiKey'),
      (conversionURL + 'ETH'+'/$currency' + '?apikey=$apiKey'),
      (conversionURL + 'LTC'+'/$currency' + '?apikey=$apiKey')
    ];
    NetworkHelper networkHelper = NetworkHelper(arrayURL);

    List<dynamic> currencyData = await networkHelper.getData();
    return currencyData;
  }
}
