import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fcm_push/fcm_push.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pec_word_image.dart';
import '../services/pec_service.dart';
import '../UI/pec_grid_item.dart';
import '../models/pec_symbol_text_display.dart';
import '../services/shared_pref_service.dart';

class PecEditor extends StatefulWidget {
  final String _requestPage;

  PecEditor(this._requestPage);

  @override
  _PecEditorState createState() => _PecEditorState();
}

class _PecEditorState extends State<PecEditor> {
  PecService pecService;
  double animatedContainerHeight;
  double buttonHeight;
  double buttonWidth;
  String requestPage;
  bool showPecEditorEngineViewImagesDisplay;
  PecSymbolTextDisplay pecSymbolTextDisplay;
  List<PecWordImage> pecWordsImages;
  List<Widget> selectedSymbolWordCards;
  FlutterTts flutterTts;
  String serverKey;
  String receipientToken;
  FCM fcm;
  FirebaseMessaging _firebaseMessaging;
  String chatID;
  String currentUserName;
  String myNumber;
  String currentChatPartnerNumber;
  String currentChatPartnerName;
  SharedPrefSingleton sharedPref;

  @override
  void initState() {
    super.initState();
    //TODO: PERFORM MEDIA QUERY TO SET SIZES
    pecService = PecService();
    animatedContainerHeight = 50.0;
    buttonHeight = 45.0;
    buttonWidth = 50.0;
    showPecEditorEngineViewImagesDisplay = false;
    pecSymbolTextDisplay = PecSymbolTextDisplay();
    selectedSymbolWordCards = List<Widget>();
    requestPage = widget._requestPage;
    flutterTts = new FlutterTts();
    sharedPref = SharedPrefSingleton();
    initilizeFcm();
  }

  initilizeFcm() async {
    if (requestPage == "ChatMessages") {
      _firebaseMessaging = FirebaseMessaging();
      _firebaseMessaging.configure(
        onLaunch: (Map<String,dynamic>msg){print(msg);},
        onMessage: (Map<String,dynamic>msg){print(msg);},
        onResume: (Map<String,dynamic>msg){print(msg);}
      );
      serverKey =
          "AAAAX4ET6QQ:APA91bHe93TenaOhfM7yabRQmw1X3voABjp8_Tsmw0oyAawOb7P2eo7vIny32BS0gOmYPa4f3SyN0e8DBCwjFP7_EzovFUKCDTjX8o8K0Askc_gfcHTBYR0_lRJNY7H-urMQxslgl4GJ"; //copy and paste this
      fcm = new FCM(serverKey);
      myNumber = await sharedPref.getUserPhoneNumber();
      currentChatPartnerNumber = await sharedPref.getCurrentChatPartnerNumber();
      currentChatPartnerName = await sharedPref.getCurrentChatPartnerName();
      currentUserName = await sharedPref.getCurrentUserFirstName();
      receipientToken = await sharedPref.getCurrentChatPartnerFcmToken();
      chatID = await sharedPref.getCurrentChatID();
    }
  }

  sendButtonFuction() async {
    if (chatID == null) {
      chatID = myNumber + currentChatPartnerNumber;
      Firestore.instance.collection('Chats').add({
        'ChatID': chatID,
        'From': myNumber,
        'FromName':currentUserName,
        'To': currentChatPartnerNumber,
        'ToName': currentChatPartnerName,
        'IsDeleted': false,
        'Time': DateTime.now()
      }).then((data) {
        print("successfully added to chats");
      });
    }
    Firestore.instance.collection('ChatMessages').add({
      'ChatID': chatID,
      'From': myNumber,    
      'To': currentChatPartnerNumber,    
      'Message': pecSymbolTextDisplay.message,
      'IsRead': false,
      'IsDeleted': false,
      'Time': DateTime.now()
    }).then((data) {
      print("successfully added to chatlist");
    });
    final Message fcmMessage = new Message()
      ..to = receipientToken
      ..title = currentUserName //_config.title
      ..body = pecSymbolTextDisplay.message; //_config.body;
    String messageID = await fcm.send(fcmMessage);
    print(fcmMessage);
    print(messageID);

  }

  displayPecWordsImages() {
    List<PecWordImage> list = pecSymbolTextDisplay.wordImageList;
    if (list.length != 0 || list != null) {
      selectedSymbolWordCards.clear();
      for (var item in list) {
        var newCard = Container(
            child: Column(
          children: <Widget>[
            Image.asset(item.image, width: 30.0, height: 20.0),
          ],
        ));
        setState(() {
          selectedSymbolWordCards.add(newCard);
        });
      }
    }
    if (selectedSymbolWordCards.length == 0) {
      selectedSymbolWordCards.clear();
      selectedSymbolWordCards.add(Container());
    }
  }

  togglePecEditorEngine() {
    bool nextToggleValue;
    double nextAnimatedContainerHeightValue;

    showPecEditorEngineViewImagesDisplay
        ? nextToggleValue = false
        : nextToggleValue = true;

    nextToggleValue
        ? nextAnimatedContainerHeightValue = 300.0
        : nextAnimatedContainerHeightValue = 50.0;

    setState(() {
      animatedContainerHeight = nextAnimatedContainerHeightValue;
      showPecEditorEngineViewImagesDisplay = nextToggleValue;
      //animationController.forward();
    });
  }

  buildPecWordSymbolList(List<PecWordImage> pecWordsImages) {
    List<PecGridItem> pecList = List<PecGridItem>();
    for (var pec in pecWordsImages) {
      PecGridItem pecItem = PecGridItem(pec, arrangeMessage);
      pecList.add(pecItem);
    }

    //WRITE TO CONSOLE
    print(pecList.length.toString());
    for (var item in pecList) {
      print(item.wordImage.word);
    }

    return pecList;
  }

  arrangeMessage(PecWordImage pecWordImage) async {
    await flutterTts.speak(pecWordImage.word);
    pecSymbolTextDisplay.addNewWordImageToList(pecWordImage);
    displayPecWordsImages();
  }

  speakButtonFunction() async {
    print(pecSymbolTextDisplay.message);
    var result = await flutterTts.speak(pecSymbolTextDisplay.message);

    //if (result == 1) setState(() => flutterTts = TtsState.playing);
  }

  deleteLastPecItem() {
    pecSymbolTextDisplay.deleteLast();
    displayPecWordsImages();
  }

  @override
  Widget build(BuildContext context) {
    List<PecGridItem> actionPecSymbolsGridItems =
        buildPecWordSymbolList(pecService.actionSymbolWordList);
    List<PecGridItem> bodyPartsPecSymbolsGridItems =
        buildPecWordSymbolList(pecService.bodyPartSymbolWordList);
    List<PecGridItem> clothingPecSymbolsGridItems =
        buildPecWordSymbolList(pecService.clothingSymbolWordList);
    List<PecGridItem> feelingPecSymbolsGridItems =
        buildPecWordSymbolList(pecService.feelingSymbolWordList);

    Widget talkActionButton = Padding(
      padding: EdgeInsets.only(
        top: 7.0,
      ),
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        child: RaisedButton(
          padding: EdgeInsets.all(0.0),
          color: Colors.blue, //_state == 2 ? Colors.green : Colors.blue,
          shape: new CircleBorder(),
          child: Icon(
            Icons.speaker,
            color: Colors.white,
          ),
          onPressed: speakButtonFunction,
          onHighlightChanged: (ispressed) {},
        ),
      ),
    );

    Widget sendActionButton = Padding(
      padding: EdgeInsets.only(
        top: 7.0,
      ),
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        child: RaisedButton(
          padding: EdgeInsets.all(0.0),
          color: Colors.blue, //_state == 2 ? Colors.green : Colors.blue,
          shape: new CircleBorder(),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: requestPage == 'ChatMessages' ? sendButtonFuction : null,
          onHighlightChanged: (ispressed) {},
        ),
      ),
    );

    Widget temporaryDisplayContainer = Container(
        width: 230.0,
        height: 45.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: EdgeInsets.all(10.0),
        ));

    Widget permanentDisplayContainer = Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Wrap(
            children: selectedSymbolWordCards,
          ),
        ));

    Widget pecSymbolTextDisplay = Expanded(
        child: Padding(
      padding: EdgeInsets.all(7.0),
      child: selectedSymbolWordCards.length == 0
          ? temporaryDisplayContainer
          : permanentDisplayContainer,
    ));

    Widget pecSymbolTextActionButtons = Wrap(
      children: <Widget>[talkActionButton, sendActionButton],
    );

    Widget pecEditorDisplayView = Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[pecSymbolTextDisplay, pecSymbolTextActionButtons],
      ),
    );

    //PART 2

    Widget topChevron = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.chevron_left,
        color: Colors.blue,
        size: 50.0,
      ),
    );

    Widget downChevron = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.chevron_right,
        color: Colors.blue,
        size: 50.0,
      ),
    );

    Widget deleteButton = Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: FlatButton(
          child: Icon(
            Icons.backspace,
            color: Colors.blue,
            size: 30.0,
          ),
          onPressed: deleteLastPecItem),
    );

    Widget pecEditorEngineViewCollapseButton = FlatButton(
        child: showPecEditorEngineViewImagesDisplay ? downChevron : topChevron,
        onPressed: togglePecEditorEngine);

    //ACTION SYMBOLS GRIDVIEW
    Widget actionPecGridView = Padding(
      padding: EdgeInsets.all(7.0),
      child: GridView.builder(
        itemCount: pecService.actionSymbolWordList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (BuildContext context, int index) {
          return actionPecSymbolsGridItems[index];
        },
      ),
    );

    //BODY PART SYMBOLS GRIDVIEW
    Widget bodyPartPecGridView = Padding(
      padding: EdgeInsets.all(7.0),
      child: GridView.builder(
        itemCount: pecService.bodyPartSymbolWordList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (BuildContext context, int index) {
          return bodyPartsPecSymbolsGridItems[index];
        },
      ),
    );

    //CLOTHING SYMBOLS GRIDVIEW
    Widget clothingPecGridView = Padding(
      padding: EdgeInsets.all(7.0),
      child: GridView.builder(
        itemCount: pecService.clothingSymbolWordList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (BuildContext context, int index) {
          return clothingPecSymbolsGridItems[index];
        },
      ),
    );

    //FEELING SYMBOLS GRIDVIEW
    Widget feelingPecGridView = Padding(
      padding: EdgeInsets.all(7.0),
      child: GridView.builder(
        itemCount: pecService.feelingSymbolWordList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (BuildContext context, int index) {
          return feelingPecSymbolsGridItems[index];
        },
      ),
    );

    //  Widget pecTabs = DefaultTabController(
    //     length: 4,
    //     child: TabBar(
    //       tabs: <Widget>[
    //         Tab(icon: Icon(Icons.ac_unit,color: Colors.blue,),),
    //         Tab(icon: Icon(Icons.access_alarm,color: Colors.blue),),
    //         Tab(icon: Icon(Icons.airport_shuttle,color: Colors.blue),),
    //         Tab(icon: Icon(Icons.web,color: Colors.blue),),
    //       ],
    //     ),
    //   );

    final pageController = PageController(
      initialPage: 0,
    );

    final pecSymbolsPageView = PageView(
      controller: pageController,
      children: <Widget>[
        actionPecGridView,
        bodyPartPecGridView,
        clothingPecGridView,
        feelingPecGridView
      ],
    );

    Widget pecEditorEngineViewImagesDisplay = Expanded(
      child: Padding(
        padding: EdgeInsets.all(5), //EdgeInsets.only(bottom: 10),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: pecSymbolsPageView //pecTabs  //####//pecGridView,
            ),
      ),
    );

    Widget pecEditorEngineView = AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: animatedContainerHeight,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              pecEditorEngineViewCollapseButton,
              showPecEditorEngineViewImagesDisplay ? deleteButton : Container()
            ],
          ),
          showPecEditorEngineViewImagesDisplay
              ? pecEditorEngineViewImagesDisplay
              : Container()
        ],
      ),
    );

    Widget pecSelectView = SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[pecEditorDisplayView, pecEditorEngineView],
        ),
      ),
    );

    //  var fadeVersion = FadeTransition(
    //     opacity: animation,
    //     child: pecEditorEngineViewImagesDisplay,
    // );

    return pecSelectView;
  }

  @override
  void dispose() {
    //animationController.dispose();
    super.dispose();
  }
}
