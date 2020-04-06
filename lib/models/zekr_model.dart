
class ZekrModel
{
  int _id, _categoryId, _counterNumber;
	String _textWithDiacritics, _textWithoutDiacritics, _sanad, _counterText;

  ZekrModel(
    this._id,
    this._categoryId,
    this._counterNumber,
	  this._textWithDiacritics,
    this._textWithoutDiacritics,
    this._sanad,
    this._counterText,
  );

  ZekrModel.fromMap(Map<String,dynamic> map)
  {
    map['id']=_id;
    map['category_id']=_categoryId;
    map['text_with_diacritics']=_textWithDiacritics;
    map['text_without_diacritics']=_textWithoutDiacritics;
    map['sanad']=_sanad;
    map['counter_text']=_counterText;
    map['counter_number']=_counterNumber;
  }

}