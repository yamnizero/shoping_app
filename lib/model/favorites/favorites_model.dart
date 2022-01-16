/// status : true
/// message : null
/// data : {"current_page":1,"data":[],"first_page_url":"https://student.valuxapps.com/api/favorites?page=1","from":null,"last_page":1,"last_page_url":"https://student.valuxapps.com/api/favorites?page=1","next_page_url":null,"path":"https://student.valuxapps.com/api/favorites","per_page":35,"prev_page_url":null,"to":null,"total":0}

class FavoritesModel {
  FavoritesModel({
      bool? status, 
      dynamic message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  FavoritesModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  dynamic _message;
  Data? _data;

  bool? get status => _status;
  dynamic get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// current_page : 1
/// data : []
/// first_page_url : "https://student.valuxapps.com/api/favorites?page=1"
/// from : null
/// last_page : 1
/// last_page_url : "https://student.valuxapps.com/api/favorites?page=1"
/// next_page_url : null
/// path : "https://student.valuxapps.com/api/favorites"
/// per_page : 35
/// prev_page_url : null
/// to : null
/// total : 0

class Data {
  Data({
      int? currentPage, 
      List<dynamic>? data, 
      String? firstPageUrl, 
      dynamic from, 
      int? lastPage, 
      String? lastPageUrl, 
      dynamic nextPageUrl, 
      String? path, 
      int? perPage, 
      dynamic prevPageUrl, 
      dynamic to, 
      int? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  Data.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(dynamic.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<dynamic>? _data;
  String? _firstPageUrl;
  dynamic _from;
  int? _lastPage;
  String? _lastPageUrl;
  dynamic _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  dynamic _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<dynamic>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  dynamic get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  dynamic get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}