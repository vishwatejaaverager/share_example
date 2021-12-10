import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_preview/image_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Share text',
                      hintText: 'Enter text '
                  ),
                  maxLines: 2,
                  onChanged: (String v) {
                    setState(() {
                      text = v;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Share text',
                      hintText: 'Enter text '
                  ),
                  maxLines: 2,
                  onChanged: (String v) {
                    setState(() {
                      text = v;
                    });
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 12.0)),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Add image'),
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        imagePaths.add(pickedFile.path);
                      });
                    }
                  },

                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: text.isEmpty && imagePaths.isEmpty ? null :() =>
                       _onShare(context), child: const Text('Share'));
                  })
              ],
            ),
          ),
        )
    );
  }

  void _onShare(BuildContext context) async{
    final box = context.findRenderObject() as RenderBox?;
    if(imagePaths.isNotEmpty){
      await Share.shareFiles(imagePaths,
      text: text,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }else{
      await Share.share(text,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }
}



