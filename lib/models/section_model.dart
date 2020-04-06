
class SectionModel
{
  int _id;
  String _name;

  SectionModel(
    this._id,
    this._name,
  );

  SectionModel.fromMap(Map<String,dynamic> map)
  {
    _id=map['id'];
    _name=map['name'];
  }

  int get id => _id;
  String get name => _name;

}