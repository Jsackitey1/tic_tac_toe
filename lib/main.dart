import 'package:flutter/material.dart';
import 'package:tic_tac_toe/tic_tac_toe_state.dart';
import 'package:flutter/services.dart';

final imageMap = {
  Player.x: Image.asset(
    'assets/images/x.png',
    errorBuilder: (context, error, stackTrace) {
      print('Error loading X image: $error');
      return const Icon(Icons.close, size: 50);
    },
  ),
  Player.o: Image.asset(
    'assets/images/o.png',
    errorBuilder: (context, error, stackTrace) {
      print('Error loading O image: $error');
      return const Icon(Icons.circle_outlined, size: 50);
    },
  )
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // ThemeData
      home: const MyHomePage(title: 'Tic Tac Toe'),
    ); // MaterialApp
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _gameState = TicTacToeState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100.0, minHeight: 120.0),
          child: AspectRatio(
            aspectRatio: 5 / 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/grid.png',
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading grid image: $error');
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                            );
                          },
                        ),
                        GridView.builder(
                          itemCount: TicTacToeState.numCells,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: TicTacToeState.size,
                          ), // SliverGridDelegateWithFixedCross
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () => _processPress(index),
                              child: imageMap[_gameState.board[index]] ?? Container(),
                            ); // TextButton
                          }, // itemBuilder
                        ), // GridView.builder
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          _gameState.getStatus(),
                          style: const TextStyle(fontSize: 36),
                        ), // Text
                      ), // FittedBox
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _resetGame,
                        child: const Text(
                          'Reset',
                          style: TextStyle(fontSize: 36),
                        ), // Text
                      ), // ElevatedButton
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _processPress(int index) {
    setState(() {
      _gameState.playAt(index);
    });
  }

  void _resetGame() {
    setState(() {
      _gameState.reset();
    });
  }
}
