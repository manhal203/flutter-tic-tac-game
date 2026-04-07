import 'dart:async';

enum Player { x, o }

class GameController {
  final void Function() onUpdate;
  GameController({required this.onUpdate});

  List<Player?> board = List.filled(9, null);
  List<int> moveHistory = [];
  List<int> winningIndexes = [];
  Player currentPlayer = Player.x;
  Player? winner;
  int xScore = 0;
  int oScore = 0;
  int draws = 0;

  void playMove(int index) {
    if (board[index] != null || winner != null) return;
    board[index] = currentPlayer;
    moveHistory.add(index);
    if (_checkWin()) {
      if (currentPlayer == Player.x) {
        xScore++;
      } else {
        oScore++;
      }
      onUpdate();
      Future.delayed(
        const Duration(seconds: 1),
        () => resetBoard(keepScore: true),
      );
    } else if (!board.contains(null)) {
      draws++;
      onUpdate();
      Future.delayed(
        const Duration(seconds: 1),
        () => resetBoard(keepScore: true),
      );
    } else {
      currentPlayer = currentPlayer == Player.x ? Player.o : Player.x;
      onUpdate();
    }
  }

  void undoMove() {
    if (moveHistory.isEmpty || winner != null) return;
    final lastIndex = moveHistory.removeLast();
    board[lastIndex] = null;
    currentPlayer = currentPlayer == Player.x ? Player.o : Player.x;
    winner = null;
    winningIndexes = [];
    onUpdate();
  }

  void resetBoard({bool keepScore = false}) {
    board = List.filled(9, null);
    moveHistory.clear();
    winningIndexes = [];
    winner = null;
    currentPlayer = Player.x;
    if (!keepScore) {
      xScore = 0;
      oScore = 0;
      draws = 0;
    }
    onUpdate();
  }

  void resetAll() => resetBoard(keepScore: false);

  bool _checkWin() {
    const patterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var p in patterns) {
      if (board[p[0]] != null &&
          board[p[0]] == board[p[1]] &&
          board[p[1]] == board[p[2]]) {
        winner = currentPlayer;
        winningIndexes = p;
        return true;
      }
    }
    return false;
  }
}
