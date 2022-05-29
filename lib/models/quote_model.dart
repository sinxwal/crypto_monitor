class QuoteModel {
  USD? uSD;
  BTC? bTC;

  QuoteModel({this.uSD, this.bTC});

  QuoteModel.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? USD.fromJson(json['USD']) : null;
    bTC = json['BTC'] != null ? BTC.fromJson(json['BTC']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    if (bTC != null) {
      data['BTC'] = bTC!.toJson();
    }
    return data;
  }
}

class USD {
  double? price;
  double? volume24h;
  double? volumeChange24h;
  double? percentChange1h;
  double? percentChange24h;
  double? percentChange7d;
  double? marketCap;
  double? marketCapDominance;
  String? lastUpdated;

  USD({
    this.price,
    this.volume24h,
    this.volumeChange24h,
    this.percentChange1h,
    this.percentChange24h,
    this.percentChange7d,
    this.marketCap,
    this.marketCapDominance,
    this.lastUpdated,
  });

  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    volume24h = json['volume_24h'];
    volumeChange24h = json['volume_change_24h'];
    percentChange1h = json['percent_change_1h'];
    percentChange24h = json['percent_change_24h'];
    percentChange7d = json['percent_change_7d'];
    marketCap = json['market_cap'];
    marketCapDominance = json['market_cap_dominance'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['volume_24h'] = volume24h;
    data['volume_change_24h'] = volumeChange24h;
    data['percent_change_1h'] = percentChange1h;
    data['percent_change_24h'] = percentChange24h;
    data['percent_change_7d'] = percentChange7d;
    data['market_cap'] = marketCap;
    data['market_cap_dominance'] = marketCapDominance;
    data['last_updated'] = lastUpdated;
    return data;
  }
}

class BTC {
  double? price;
  double? volume24h;
  double? volumeChange24h;
  double? percentChange1h;
  double? percentChange24h;
  double? percentChange7d;
  double? marketCap;
  double? marketCapDominance;
  String? lastUpdated;

  BTC({
    this.price,
    this.volume24h,
    this.volumeChange24h,
    this.percentChange1h,
    this.percentChange24h,
    this.percentChange7d,
    this.marketCap,
    this.marketCapDominance,
    this.lastUpdated,
  });

  BTC.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    volume24h = json['volume_24h'];
    volumeChange24h = json['volume_change_24h'];
    percentChange1h = json['percent_change_1h'];
    percentChange24h = json['percent_change_24h'];
    percentChange7d = json['percent_change_7d'];
    marketCap = json['market_cap'];
    marketCapDominance = json['market_cap_dominance'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['volume_24h'] = volume24h;
    data['volume_change_24h'] = volumeChange24h;
    data['percent_change_1h'] = percentChange1h;
    data['percent_change_24h'] = percentChange24h;
    data['percent_change_7d'] = percentChange7d;
    data['market_cap'] = marketCap;
    data['market_cap_dominance'] = marketCapDominance;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
