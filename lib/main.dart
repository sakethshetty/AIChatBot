import 'package:flutter/material.dart';
import 'package:untitled/dp.dart';
import 'package:untitled/pallet.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'feature.dart';
import 'openAiService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Pallet.bodyBackground,
          appBarTheme: AppBarTheme(
            backgroundColor: Pallet.appBarBackground,
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var name = "user";
  final speechToText = SpeechToText();
  String lastWords = '';
  final openAiService = OpenAIService();
  var lastWordController = TextEditingController();
  List<String> aiMsg = [], userMsg = [];
  final flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    //initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  FloatingActionButton floatingMic() {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Pallet.micColor,
      child: const Icon(Icons.mic),
      onPressed: () async {
        if (await speechToText.hasPermission && speechToText.isNotListening) {
          await startListening();
        } else if (speechToText.isListening) {
          print(lastWords);
          //lastWordController.text = lastWords;
          //lastWords = "";
          aiMsg.add(await OpenAIService.chatGptApi(lastWords));
          userMsg.add(lastWords);
          initTextToSpeech();
          systemSpeak(aiMsg.last);
          stopListening();
        } else {
          await initSpeechToText();
        }
      },
    );
  }

  FloatingActionButton floatingSend() {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Pallet.micColor,
      child: const Icon(Icons.send_rounded),
      onPressed: () async {
        if (lastWordController.text.isNotEmpty) {
          userMsg.add(lastWordController.text);
          aiMsg.add(await OpenAIService.chatGptApi(lastWordController.text));
          initTextToSpeech();
          systemSpeak(aiMsg.last);
          print(aiMsg.last);
          lastWordController.clear();
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: const Text("BRAIN"),
          /*actions: [
            Builder(builder: (context) {
              return InkWell(
                child: const CircleAvatar(
                  child: Icon(Icons.settings),
                ),
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            })
          ],*/
        ),
        /*endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    const CircleAvatar(
                      child: Icon(
                        Icons.account_circle,
                        size: 50.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),*/
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: ListView.builder(
                  itemCount: aiMsg.length + 1,
                  itemBuilder: (context, index) => (index == 0)
                      ? AssisImage.assistantImage()
                      : Column(
                        children: [
                          userTextBox(msg: userMsg[index-1]),
                          aiTextBox(msg: aiMsg[index-1]),
                        ],
                      )),
            ),
            Expanded(
              flex: 2,
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 60,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 82,
                      child: Container(
                        padding: const EdgeInsets.all(4.0).copyWith(left: 2.0),
                        margin: const EdgeInsets.all(5.0).copyWith(left: 2.0),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {});
                          },
                          controller: lastWordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            hintText: "What can I do for you?",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 18,
                      child: Container(
                        padding: const EdgeInsets.all(4.0).copyWith(left: 2.0),
                        margin: const EdgeInsets.all(5.0).copyWith(left: 2.0),
                        child: lastWordController.text.isEmpty
                            ? floatingMic() // Widget or function to be inserted if the condition is true
                            : floatingSend(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }
}
