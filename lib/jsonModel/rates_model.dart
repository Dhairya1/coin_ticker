// class rates_model {
//   String assetIdBase;
//   late List<Rates> rates;
//
//   rates_model({required this.assetIdBase, required this.rates});
//
//   rates_model.fromJson(Map<String, dynamic> json) {
//     assetIdBase = json['asset_id_base'];
//     if (json['rates'] != null) {
//       rates = <Rates>[];
//       json['rates'].forEach((v) {
//         rates.add(new Rates.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['asset_id_base'] = this.assetIdBase;
//     if (this.rates != null) {
//       data['rates'] = this.rates.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Rates {
//   String time;
//   String assetIdQuote;
//   double rate;
//
//   Rates({required this.time, required this.assetIdQuote, required this.rate});
//
//   Rates.fromJson(Map<String, dynamic> json) {
//     time = json['time'];
//     assetIdQuote = json['asset_id_quote'];
//     rate = json['rate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['time'] = this.time;
//     data['asset_id_quote'] = this.assetIdQuote;
//     data['rate'] = this.rate;
//     return data;
//   }
// }