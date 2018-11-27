class PecWordImage{
  String _word;
  String _imagePath;

  PecWordImage(this._word,this._imagePath);

  set setWord(String value){
    _word = value;
  }

  set setImage(String value){
    _imagePath = value;
  }

  String get word => _word;
  String get image => _imagePath;
}