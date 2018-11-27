import 'package:scoped_model/scoped_model.dart';
import '../models/pec_word_image.dart';

class PecSymbolTextDisplay extends Model {
  List<PecWordImage> _wordImageList;
  String _message;

  PecSymbolTextDisplay() {
    _wordImageList = List<PecWordImage>();
    _message = '';
  }

  addNewWordImageToList(PecWordImage wordImage) {
    _wordImageList.add(wordImage);
    notifyListeners();
  }

  deleteLast() {
    if (_wordImageList.length != 0) {
      _wordImageList.removeLast();
      notifyListeners();
    }
  }

  get wordImageList => _wordImageList;

  get message => getMessage();

  getMessage() {
    _message = '';
    if (_wordImageList.length != 0) {
      for (var item in _wordImageList) {
        _message = _message + ' ' + item.word.toString();
      }
    } else {
      _message = '';
    }

    return _message;
  }
}
