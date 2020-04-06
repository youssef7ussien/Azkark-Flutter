
class AsmaAllahModel
{
  int _id;
  String _name, _description;

  AsmaAllahModel(
    this._id,
    this._name,
    this._description,
  );

  AsmaAllahModel.fromMap(Map<String,dynamic> map)
  {
    map['id']=_id;
    map['name']=_name;
    map['description']=_description;
  }
}