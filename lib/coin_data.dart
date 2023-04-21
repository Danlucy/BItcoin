import 'dart:convert';
import 'package:http/http.dart' as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
// const apiKey = '4BEAC3DA-5234-4548-956B-3076FE9B97BF';
const apiKey = 'F144A3A0-7867-4654-98A7-CC34639B8F2B';
// const apiKey = '813D14A8-A27F-4A43-8135-966A97A5428F';

class CoinData {
  Future<Map<String, double>> getCoinData(String selectedCurrency) async {
    final mapData = <String, double>{};

    for (String datas in cryptoList) {
      String requestURL = '$coinAPIURL/$datas/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];

        mapData[datas] = lastPrice;
        print(mapData);
      } else {
        print(response.statusCode);

        throw 'Problem with the get request';
      }
    }
    return mapData;
  }
}
