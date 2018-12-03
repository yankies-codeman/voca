import '../models/pec_word_image.dart';

class PecService {
  List<PecWordImage> _actionSymbolWordList;
  List<PecWordImage> _bodyPartSymbolWordList;
  List<PecWordImage> _clothingSymbolWordList;
  List<PecWordImage> _feelingSymbolWordList;

  PecService() {
    initializeService();
  }

  initializeService() {
    _actionSymbolWordList = List<PecWordImage>();
    _bodyPartSymbolWordList = List<PecWordImage>();
    _clothingSymbolWordList = List<PecWordImage>();
    _feelingSymbolWordList = List<PecWordImage>();

    PecWordImage ask = PecWordImage('ask', 'assets/pecsymbols/action/ask.PNG');
    PecWordImage bathe =
        PecWordImage('bathe', 'assets/pecsymbols/action/bathe.PNG');
    PecWordImage bodyShakes =
        PecWordImage('body shakes', 'assets/pecsymbols/action/bodyShakes.PNG');
    PecWordImage breathe =
        PecWordImage('breathe', 'assets/pecsymbols/action/breathe.PNG');
    PecWordImage bring =
        PecWordImage('bring', 'assets/pecsymbols/action/bring.PNG');
    PecWordImage buy = PecWordImage('buy', 'assets/pecsymbols/action/buy.PNG');
    PecWordImage clap =
        PecWordImage('clap', 'assets/pecsymbols/action/clap.PNG');
    PecWordImage carry =
        PecWordImage('carry', 'assets/pecsymbols/action/carry.PNG');
    PecWordImage change =
        PecWordImage('change clothes', 'assets/pecsymbols/action/change clothes.PNG');
    PecWordImage checkMessage =
        PecWordImage('check messages', 'assets/pecsymbols/action/check messages.PNG');
    PecWordImage choke =
        PecWordImage('choke', 'assets/pecsymbols/action/choke.PNG');
    PecWordImage come =
        PecWordImage('come', 'assets/pecsymbols/action/come.PNG');
    PecWordImage cleanUp =
        PecWordImage('clean up', 'assets/pecsymbols/action/clean up.PNG');
    PecWordImage congratulations = PecWordImage(
        'congratulations', 'assets/pecsymbols/action/congratulations.PNG');
    PecWordImage dance =
        PecWordImage('dance', 'assets/pecsymbols/action/dance.PNG');
    PecWordImage doSome = PecWordImage('do', 'assets/pecsymbols/action/do.PNG');
    PecWordImage dont =
        PecWordImage('dont', 'assets/pecsymbols/action/dont.PNG');
    PecWordImage dress =
        PecWordImage('dress', 'assets/pecsymbols/action/dress up.PNG');
    PecWordImage drink =
        PecWordImage('drink', 'assets/pecsymbols/action/drink.PNG');
    PecWordImage drive =
        PecWordImage('drive', 'assets/pecsymbols/action/drive.PNG');
    PecWordImage eat = PecWordImage('eat', 'assets/pecsymbols/action/eat.PNG');

    _actionSymbolWordList.add(ask);
    _actionSymbolWordList.add(bathe);
    _actionSymbolWordList.add(bodyShakes);
    _actionSymbolWordList.add(breathe);
    _actionSymbolWordList.add(bring);
    _actionSymbolWordList.add(buy);
    _actionSymbolWordList.add(clap);
    _actionSymbolWordList.add(carry);
    _actionSymbolWordList.add(change);
    _actionSymbolWordList.add(checkMessage);
    _actionSymbolWordList.add(choke);
    _actionSymbolWordList.add(come);
    _actionSymbolWordList.add(cleanUp);
    _actionSymbolWordList.add(congratulations);
    _actionSymbolWordList.add(dance);
    _actionSymbolWordList.add(doSome);
    _actionSymbolWordList.add(dont);
    _actionSymbolWordList.add(dress);
    _actionSymbolWordList.add(drink);
    _actionSymbolWordList.add(drive);
    _actionSymbolWordList.add(eat);

    //BODY PARTS
    PecWordImage ankle =
        PecWordImage('ankle', 'assets/pecsymbols/body parts/ankle.PNG');
    PecWordImage arm =
        PecWordImage('arm', 'assets/pecsymbols/body parts/arm.PNG');
    PecWordImage back =
        PecWordImage('back', 'assets/pecsymbols/body parts/back.PNG');
    PecWordImage breast =
        PecWordImage('breast', 'assets/pecsymbols/body parts/breast.PNG');
    PecWordImage buttocks =
        PecWordImage('buttocks', 'assets/pecsymbols/body parts/buttocks.PNG');
    PecWordImage chest =
        PecWordImage('chest', 'assets/pecsymbols/body parts/chest.PNG');
    PecWordImage chin =
        PecWordImage('chin', 'assets/pecsymbols/body parts/chin.PNG');
    PecWordImage ear =
        PecWordImage('ear', 'assets/pecsymbols/body parts/ear.PNG');
    _bodyPartSymbolWordList.add(ankle);
    _bodyPartSymbolWordList.add(arm);
    _bodyPartSymbolWordList.add(back);
    _bodyPartSymbolWordList.add(breast);
    _bodyPartSymbolWordList.add(buttocks);
    _bodyPartSymbolWordList.add(chest);
    _bodyPartSymbolWordList.add(chin);
    _bodyPartSymbolWordList.add(ear);

    //CLOTHING
    PecWordImage shirt =
        PecWordImage('shirt', 'assets/pecsymbols/clothing/shirt.PNG');
    PecWordImage shoe =
        PecWordImage('shoe', 'assets/pecsymbols/clothing/shoe.PNG');
    PecWordImage sanitaryNapkin = PecWordImage(
        'sanitary napkin', 'assets/pecsymbols/clothing/sanitary napkin.PNG');
    PecWordImage panties =
        PecWordImage('panties', 'assets/pecsymbols/clothing/panties.PNG');
    PecWordImage skirt =
        PecWordImage('skirt', 'assets/pecsymbols/clothing/skirt.PNG');
    _clothingSymbolWordList.add(skirt);
    _clothingSymbolWordList.add(shirt);
    _clothingSymbolWordList.add(shoe);
    _clothingSymbolWordList.add(panties);
    _clothingSymbolWordList.add(sanitaryNapkin);

    //FEELINGS
    PecWordImage ashamed =
        PecWordImage('ashamed', 'assets/pecsymbols/feelings/ashamed.PNG');
    PecWordImage afraid =
        PecWordImage('afraid', 'assets/pecsymbols/feelings/afraid.PNG');
    PecWordImage cold1 =
        PecWordImage('cold', 'assets/pecsymbols/feelings/cold1.PNG');
    PecWordImage excited =
        PecWordImage('excited', 'assets/pecsymbols/feelings/excited.PNG');
    _feelingSymbolWordList.add(ashamed);
    _feelingSymbolWordList.add(afraid);
    _feelingSymbolWordList.add(cold1);
    _feelingSymbolWordList.add(excited);
  }

  List<PecWordImage> get actionSymbolWordList => _actionSymbolWordList;
  List<PecWordImage> get bodyPartSymbolWordList => _bodyPartSymbolWordList;
  List<PecWordImage> get clothingSymbolWordList => _clothingSymbolWordList;
  List<PecWordImage> get feelingSymbolWordList => _feelingSymbolWordList;
}

// checkDirContent(){
//   print('Checking Directory');
//   var dir = Directory('../assets/pecsymbols/action');
//   List content = dir.listSync();
//   content.forEach((item){
//     item is File ? print(item.toString()) : print('Not file');
//   });
// }

//  - assets/pecsymbols/action/eat with hands.PNG
//  - assets/pecsymbols/action/eat.PNG
//  - assets/pecsymbols/action/fight.PNG
//  - assets/pecsymbols/action/fix.PNG
//  - assets/pecsymbols/action/give.PNG
//  - assets/pecsymbols/action/go to school.PNG
//  - assets/pecsymbols/action/go.PNG
//  - assets/pecsymbols/action/help.PNG
//  - assets/pecsymbols/action/hold.PNG
//  - assets/pecsymbols/action/listen.PNG
