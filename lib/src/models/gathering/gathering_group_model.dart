class GatheringGroupModel {
  String name;
  String type;
  int rangeTime;
  int cash;
  int consumtion;

  GatheringGroupModel(
      {this.name, this.type, this.rangeTime, this.cash, this.consumtion});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.name;
    data['type'] = this.type;
    data['rangeTime'] = this.rangeTime;
    data['cash'] = this.cash;
    data['consumtion'] = this.consumtion;
    return data;
  }
}
