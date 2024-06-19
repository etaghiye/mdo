class CarMakes {
  int? count;
  String? message;
  List<Make>? results;

  CarMakes({this.count, this.message, this.results});

  CarMakes.fromJson(Map<String, dynamic> json) {
    count = json['Count'];
    message = json['Message'];
    if (json['Results'] != null) {
      results = <Make>[];
      json['Results'].forEach((v) {
        results!.add(Make.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Count'] = this.count;
    data['Message'] = this.message;
    if (results != null) {
      data['Results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Make {
  int? makeID;
  String? makeName;

  Make({this.makeID, this.makeName});

  Make.fromJson(Map<String, dynamic> json) {
    makeID = json['Make_ID'];
    makeName = json['Make_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Make_ID'] = makeID;
    data['Make_Name'] = makeName;
    return data;
  }
}
