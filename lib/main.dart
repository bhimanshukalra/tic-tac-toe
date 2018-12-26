import 'package:flutter/material.dart';
import 'package:tictactoe/custom_dialog.dart';
import 'package:tictactoe/game_button.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      theme: ThemeData.dark(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonList;
  var player1, player2, activePlayer;

  @override
  void initState() {
    super.initState();
    buttonList = doInit();
  }

  List<GameButton> doInit() {
    player1 = new List();
    player2 = new List();
    activePlayer = 1;
    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gameButton) {
    setState(() {
      if (activePlayer == 1) {
        gameButton.text = "X";
        gameButton.bgColor = Colors.red;
        activePlayer = 2;
        player1.add(gameButton.id);
      } else {
        gameButton.text = "O";
        gameButton.bgColor = Colors.black;
        activePlayer = 1;
        player2.add(gameButton.id);
      }
      gameButton.isEnabled = false;
      checkWinner();
    });
  }

  void checkWinner() {
    var winner = -1;
    //row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3))
      winner = 1;
    else if (player2.contains(1) && player2.contains(2) && player2.contains(3))
      winner = 2;
    //row 2
    else if (player1.contains(4) && player1.contains(5) && player1.contains(6))
      winner = 1;
    else if (player2.contains(4) && player2.contains(5) && player2.contains(6))
      winner = 2;
    //row3
    else if (player1.contains(7) && player1.contains(8) && player1.contains(9))
      winner = 1;
    else if (player2.contains(7) && player2.contains(8) && player2.contains(9))
      winner = 2;
    //col 1
    else if (player1.contains(1) && player1.contains(4) && player1.contains(7))
      winner = 1;
    else if (player2.contains(1) && player2.contains(4) && player2.contains(7))
      winner = 2;
    //col 2
    else if (player1.contains(2) && player1.contains(5) && player1.contains(8))
      winner = 1;
    else if (player2.contains(2) && player2.contains(5) && player2.contains(8))
      winner = 2;
    //col 3
    else if (player1.contains(3) && player1.contains(6) && player1.contains(9))
      winner = 1;
    else if (player2.contains(3) && player2.contains(6) && player2.contains(9))
      winner = 2;
    //diagonal 1
    else if (player1.contains(1) && player1.contains(5) && player1.contains(9))
      winner = 1;
    else if (player2.contains(1) && player2.contains(5) && player2.contains(9))
      winner = 2;
    //diagonal 2
    else if (player1.contains(3) && player1.contains(5) && player1.contains(7))
      winner = 1;
    else if (player2.contains(3) && player2.contains(5) && player2.contains(7))
      winner = 2;
    //WINNER CONDITION
    if (winner == 1)
      showDialog(
          context: context,
          builder: (_) => CustomDialog(
              "Player 1 won", "Press the reset button", resetGame));
    else if (winner == 2)
      showDialog(
          context: context,
          builder: (_) => CustomDialog(
              "Player 2 won", "Press the reset button", resetGame));
    else if (buttonList.every((p) => p.text != ""))
      showDialog(
          context: context,
          builder: (_) =>
              CustomDialog("Game Tied", "Press the reset button", resetGame));
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe  #"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Text(
                "Turn: Player $activePlayer",
                style: TextStyle(fontSize: 50.0),
                textAlign: TextAlign.center,
              ),
              color: activePlayer == 1 ? Colors.red : Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0),
              itemBuilder: (context, index) => RaisedButton(
                    onPressed: buttonList[index].isEnabled
                        ? () => playGame(buttonList[index])
                        : null,
                    padding: EdgeInsets.all(8.0),
                    color: buttonList[index].bgColor,
                    disabledColor: buttonList[index].bgColor,
                    child: Text(
                      buttonList[index].text,
                      style: TextStyle(
                        fontSize: 60.0,
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              itemCount: buttonList.length,
            ),
          ),
          RaisedButton(
            onPressed: resetGame,
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            color: Colors.red,
            padding: EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }
}