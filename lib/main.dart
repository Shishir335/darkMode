import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final shared = await SharedPreferences.getInstance();
  if (shared.getBool('dark') == null) {
    shared.setBool('dark', false);
  }

  runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final provider = Provider.of<ThemeProvider>(context);

        provider.setTheme(shared.getBool('dark')!);

        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: provider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Switch.adaptive(
              value: provider.isDarkMode,
              onChanged: (value) async {
                print(value);
                final provider =
                    Provider.of<ThemeProvider>(context, listen: false);

                final prefs = await SharedPreferences.getInstance();

                prefs.setBool('dark', value);

                provider.toggleTheme(value);
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('$_counter',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add)),
    );
  }
}
