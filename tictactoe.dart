import 'package:flutter/material.dart';

void main() => runApp(TicTacToeApp());

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToeHomePage(),
    );
  }
}

class TicTacToeHomePage extends StatefulWidget {
  @override
  _TicTacToeHomePageState createState() => _TicTacToeHomePageState();
}

class _TicTacToeHomePageState extends State<TicTacToeHomePage> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = '';
    });
  }

  void _makeMove(int index) {
    if (_board[index] == '' && _winner == '') {
      setState(() {
        _board[index] = _currentPlayer;
        _winner = _checkWinner();
        if (_winner == '') {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  String _checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] != '' &&
          _board[pattern[0]] == _board[pattern[1]] &&
          _board[pattern[1]] == _board[pattern[2]]) {
        return _board[pattern[0]];
      }
    }

    if (!_board.contains('')) {
      return 'Draw';
    }

    return '';
  }

  Widget _buildCell(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _makeMove(index),
        child: Container(
          margin: EdgeInsets.all(4.0),
          color: Colors.blue[100],
          child: Center(
            child: Text(
              _board[index],
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: _board[index] == 'X' ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildCell(0),
                    _buildCell(1),
                    _buildCell(2),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildCell(3),
                    _buildCell(4),
                    _buildCell(5),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildCell(6),
                    _buildCell(7),
                    _buildCell(8),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            _winner == ''
                ? 'Current Player: $_currentPlayer'
                : _winner == 'Draw'
                    ? 'Game Draw'
                    : 'Winner: $_winner',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}