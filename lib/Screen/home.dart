import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:jarvisgpt/Components/Featurebox.dart';
import 'package:jarvisgpt/services/opeanAI.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../Components/Logbar.dart';
import '../Components/MyDrawer.dart';
import '../Components/Promptbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechToText stt = SpeechToText();
  // bool _speechEnabled = false;
  TextEditingController promptsearch = new TextEditingController();
  String _lastWords = '';
  OpenAPIService openapi = OpenAPIService();
  bool getprompt = false;

  @override
  void dispose() {
    super.dispose();
    stt.stop();
  }

  @override
  Widget build(BuildContext context) {
    // FocusScopeNode currentfocus = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('JarvisGPT'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 220,
                            width: 220,
                            margin: EdgeInsets.only(top: 5),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-vector/flat-design-illustration-customer-support_23-2148887720.jpg?w=2000'))),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () => setState(() {
                              _lastWords = "";
                              getprompt = false;
                            }),
                        child: promptbar(
                            data: _lastWords.isEmpty
                                ? "Good Morning, what task can I do for you?"
                                : _lastWords,
                            fontsize: 25)),
                    logbar(
                        desc: _lastWords.isEmpty
                            ? "Here you can also do :😎😎"
                            : "👇👇👇Here is your Solution :😏"),
                    getprompt
                        ? FutureBuilder(
                            initialData: null,
                            future: openapi.GetPrompt(_lastWords),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Column(
                                  children: [
                                    logbar(
                                        desc:
                                            "Relax😎 it may take more time...🥲🙃"),
                                    LinearProgressIndicator()
                                  ],
                                );
                              }
                              final data = snapshot.data;
                              print(data);
                              return 
                              promptbar(
                                data: data,
                                fontsize: 15,
                              );
                            },
                          )
                        // _AIreply.isNotEmpty
                        //     ? Container(
                        //         // height: 500,
                        //         margin: EdgeInsets.only(top: 15),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 color: Color.fromRGBO(200, 200, 200, 1)),
                        //             borderRadius: BorderRadius.circular(20)
                        //                 .copyWith(topLeft: Radius.zero)),
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 30, vertical: 20),
                        //         child: SingleChildScrollView(
                        //           child: Text(
                        //             "AI: $_AIreply",
                        //             style: TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Color.fromRGBO(19, 61, 95, 1)),
                        //           ),
                        //         ),
                        //       )
                        : Column(
                            children: [
                              FeatureBox(
                                  color: Colors.blue.shade300,
                                  title: "ChatGPT",
                                  desc:
                                      'A smarter way to stay organized and informed with ChatGPT'),
                              FeatureBox(
                                  color: Colors.indigoAccent.shade100,
                                  title: "Dall-e",
                                  desc:
                                      'Get inspired and stay creative with your personal assistant powered by Dall-E'),
                              FeatureBox(
                                  color: Colors.blueGrey.shade200,
                                  title: "Smart Voice Assistant",
                                  desc:
                                      'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT')
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.pink.shade100),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: promptsearch,
                  autofocus: false,
                  autocorrect: true,
                  enableSuggestions: true,
                  onTap: () => setState(() {
                    _lastWords = "";
                  }),
                  onSubmitted: (value) {
                    _lastWords = promptsearch.text;
                    setState(() {
                      getprompt = true;
                    });

                    // callChatgpt();
                    // currentfocus.requestFocus(new FocusNode());
                    promptsearch.clear();
                  },
                  // enabled: false,
                  // showCursor: false,

                  decoration: InputDecoration(
                      // filled: true,
                      contentPadding: const EdgeInsets.only(left: 14.0),
                      border: InputBorder.none,
                      hintText: "Send a message",
                      fillColor: Colors.white,
                      // suffixIcon: Icon(Icons.abc),
                      icon: Icon(Icons.ac_unit)),
                )),
                AvatarGlow(
                    animate: stt.isListening,
                    endRadius: 30.0,
                    glowColor: Theme.of(context).primaryColorDark,
                    child: GestureDetector(
                      onTap: () => _listen(),
                      child: CircleAvatar(
                        radius: 30,
                        child: Icon(stt.isListening
                            ? Icons.stop_rounded
                            : Icons.mic_none_rounded),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _listen() async {
    if (stt.isNotListening) {
      bool available = await stt.initialize(
        onStatus: (status) async {
          print('Onstatus: $status');
          if (status == 'done') {
            setState(() {
              getprompt = true;
            });
            print(_lastWords);
            // await callChatgpt();
          }
        },
        onError: (errorNotification) => print("error: $errorNotification"),
      );

      if (available) {
        print("Listening");
        stt.listen(
          onResult: (result) => setState(() {
            getprompt = false;
            _lastWords = result.recognizedWords;
          }),
        );
      }
    } else {
      print("Stop");
      setState(() {});
      stt.stop();
    }
  }
}
