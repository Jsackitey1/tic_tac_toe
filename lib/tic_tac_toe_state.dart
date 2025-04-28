enum Player {
  none('-'),
  x('x'),
  o('o');

  final String str;
  const Player(this.str);

  @override
  String toString() => str;
}

class TicTacToeState {
  static const size = 3;
  static const numCells = size * size;
  static const lines = [
    [0, 1, 2], // row 0
    [3, 4, 5], // row 1
    [6, 7, 8], // row 2
    [0, 3, 6], // col 0
    [1, 4, 7], // col 1
    [2, 5, 8], // col 2
    [0, 4, 8], // diag \
    [2, 4, 6], // diag /
  ];

  late List<Player> board;
  late Player currentPlayer, winner;
  late int turn;

  TicTacToeState() {
    reset();
  }

  void reset() {
    board = List.filled(numCells, Player.none);
    currentPlayer = Player.x;
    winner = Player.none;
    turn = 0;
  }

  bool playAt(int i) {
    if (winner == Player.none && board[i] == Player.none) {
      board[i] = currentPlayer;
      currentPlayer = (currentPlayer == Player.x) ? Player.o : Player.x;
      turn++;
      _checkWinner();
      return true;
    }
    return false;
  }

  void _checkWinner() {
    for (List<int> line in lines) {
      if (board[line[0]] != Player.none &&
          board[line[0]] == board[line[1]] &&
          board[line[0]] == board[line[2]]) {
        winner = board[line[0]];
        return;
      }
    }
  }

  Player getWinner() => winner;

  bool get isGameOver => winner != Player.none || turn == numCells;

  String getStatus() {
    if (isGameOver) {
      if (winner == Player.none) {
        return 'Draw.';
      } else {
        return '$winner wins!';
      }
    } else {
      return '$currentPlayer to play.';
    }
  }

  @override
  String toString() {
    var sb = StringBuffer();
    for (int i = 0; i < board.length; i++) {
      sb.write(board[i].toString());
      if (i % size == size - 1) {
        sb.write('\n');
      }
    }
    return sb.toString();
  }
}

// Test code:
void main() {
  var s = TicTacToeState();
  print(s);
  var plays = [4, 0, 2, 6, 3, 5, 7, 1, 8];
  for (var i in plays) {
    print('Playing at $i.\n');
    s.playAt(i);
    print(s);
  }
}
