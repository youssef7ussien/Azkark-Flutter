
class CategoryModel
{
  int _id, _sectionId,_favorite;
	String _nameWithDiacritics, _nameWithoutDiacritics;

  CategoryModel(
    this._id,
    this._sectionId,
	  this._nameWithDiacritics,
    this._nameWithoutDiacritics,
    this._favorite,
  );

  CategoryModel.fromMap(Map<String,dynamic> map)
  {
    _id=map['id'];
    _sectionId=map['section_id'];
    _favorite=map['favorite'];
    _nameWithDiacritics=map['name_with_diacritics'];
    _nameWithoutDiacritics=map['name_without_diacritics'];
  }

  int get id => _id;
  
  int get sectionId => _sectionId;
  
  String get nameWithDiacritics => _nameWithDiacritics;
  
  String get nameWithoutDiacritics => _nameWithoutDiacritics;
  
  int get favorite => _favorite;

}