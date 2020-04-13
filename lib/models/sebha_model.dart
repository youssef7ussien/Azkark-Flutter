

class SebhaModel
{
  int _id,_counter;
  String _nameWithDiacritics, _nameWithoutDiacritics;

  SebhaModel(
    this._id,
    this._nameWithDiacritics,
    this._nameWithoutDiacritics,
    this._counter,
  );

  SebhaModel.fromMap(Map<String,dynamic> map)
  {
    _id=map['id'];
    _nameWithDiacritics=map['name_with_diacritics'];
    _nameWithoutDiacritics=map['name_without_diacritics'];
    _counter=map['counter'];
  }
  
  Map<String,dynamic> toMap()
  {
    return {
      'id':_id,
      'name_with_diacritics':_nameWithDiacritics,
      'name_without_diacritics':_nameWithoutDiacritics,
      'counter':_counter,
    };
  }

  void setNameWithDiacritics(String value)
  {
    _nameWithDiacritics=value;
  }

  void setNameWithoutDiacritics(String value)
  {
    _nameWithoutDiacritics=value;
  }
  
  void setCounter(int value)
  {
    _counter=value;
  }

  int get id => _id;

  String get nameWithDiacritics => _nameWithDiacritics;

  String get nameWithoutDiacritics => _nameWithoutDiacritics;

  int get counter => _counter;

}