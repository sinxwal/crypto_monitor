import 'quote_model.dart';

class DataModel {
  int? id;
  String? name;
  String? symbol;
  String? slug;
  int? cmcRank;
  int? numMarketPairs;
  String? lastUpdated;
  String? dateAdded;
  QuoteModel? quote;

  DataModel({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.cmcRank,
    this.numMarketPairs,
    this.lastUpdated,
    this.dateAdded,
    this.quote,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    slug = json['slug'];
    cmcRank = json['cmc_rank'];
    numMarketPairs = json['num_market_pairs'];
    lastUpdated = json['last_updated'];
    dateAdded = json['date_added'];
    quote = json['quote'] != null ? QuoteModel.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['slug'] = slug;
    data['cmc_rank'] = cmcRank;
    data['num_market_pairs'] = numMarketPairs;
    data['last_updated'] = lastUpdated;
    data['date_added'] = dateAdded;
    if (quote != null) {
      data['quote'] = quote!.toJson();
    }
    return data;
  }
}
