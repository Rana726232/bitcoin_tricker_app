import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'BDT',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

var url = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'D18F0D0D-6699-4D11-9AAD-37539E0D9133';

class CoinData {
  Future getCoinData(String allCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      http.Response response = await http.get(
        Uri.parse('$url/$crypto/$allCurrency?apikey=$apiKey'),
      );
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }
}
