import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gambit/flutter_chess_board.dart';
import 'package:gambit/src/chess_board.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PVPblack extends StatefulWidget {
  const PVPblack(this.player1, this.player2, {super.key});
  final String player1;
  final String player2;

  @override
  State<PVPblack> createState() => _PVPblackState();
}

class _PVPblackState extends State<PVPblack> {
  late ChessBoardController controller;
  late WebSocketChannel channel;
  List<BoardArrow> arrows = [];
  String tempmove = '';
  String username = '';
  int userRating = 0;
  PlayerColor pcolor = PlayerColor.black;
  bool enableusermoves = true;

  @override
  void initState() {
    super.initState();
    controller = ChessBoardController();
    getValidationData();
    _connectToWebsocket();
  }

  Future<void> getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username') ?? '';
    setState(() {
      if (username == widget.player1) {
        pcolor = PlayerColor.white;
      }
      userRating = sharedPreferences.getInt('rating') ?? 0;
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _connectToWebsocket() {
    channel = IOWebSocketChannel.connect('ws://10.0.2.2:8070');

    channel.sink.add(jsonEncode({
      'type': 'join',
      'username': username,
      'rating': userRating,
      'color': pcolor == PlayerColor.white ? 'white' : 'black',
    }));

    channel.stream.listen((data) {
      final message = jsonDecode(data);
      if (message['content'] != null) {
        setState(() {
          // Add the received move to the local chessboard
       
      controller.makeMove(
          from: message['content'].substring(0, 2), to: message['content'].substring(2, 4));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height * 0.10;
    var playername =
        pcolor == PlayerColor.white ? widget.player1 : widget.player2;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: const Text('Match'),
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            // Widget for player information
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 5),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/blur.jpg'),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                ),
                Text(
                  playername,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    backgroundColor: Colors.black,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            // Widget for the chessboard
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ChessBoard(
                    size: 350,
                    enableUserMoves: enableusermoves,
                    onMove: (move) {
                      channel.sink.add(jsonEncode({
                        'type': 'move',
                        'move': move,
                      }));

                      setState(() {
                        tempmove = move;
                      });
                    },
                    controller: controller,
                    boardColor: BoardColor.brown,
                    arrows: arrows,
                    boardOrientation: pcolor,
                  ),
                ),
              ),
            ),
            // Widget for displaying game moves
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ValueListenableBuilder<Chess>(
                    valueListenable: controller,
                    builder: (context, game, _) {
                      return Text(
                        controller.getSan().fold(
                              '',
                              (previousValue, element) =>
                                  '$previousValue\n${element ?? ''}',
                            ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.brown.withOpacity(0.70),
                          fontFamily: "Times New Roman",
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
