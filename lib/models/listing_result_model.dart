import 'data_model.dart';
import 'status_model.dart';

class ListingResultModel {
  List<DataModel>? data;
  StatusModel? status;

  ListingResultModel({this.data, this.status});

  ListingResultModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
    status =
        json['status'] != null ? StatusModel.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    return data;
  }
}
