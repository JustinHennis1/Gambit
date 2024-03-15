import 'package:flutter/material.dart';
import 'package:gambit/pages/play_as_blk.dart';
import 'package:gambit/pages/play_as_wht.dart';

class GameButt extends StatefulWidget {
  const GameButt(this.choice, this.text1, {super.key});

  final int choice;
  final String text1;

  @override
  State<GameButt> createState() => _GameButtState();
}

class _GameButtState extends State<GameButt> {
  String? selectedOption;

  Future<void> _showOptionsDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black, // Set black background
          title: const Text(
            'Select Option',
            style: TextStyle(color: Colors.amber), // Amber text color
          ),
          content: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedOption = 'Random';
                  });
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                ),
                child: const Text('Random',
                    style: TextStyle(color: Colors.black)), // Black text color
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedOption = 'White';
                  });
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                ),
                child: const Text('White',
                    style: TextStyle(color: Colors.black)), // Black text color
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedOption = 'Black';
                  });
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                ),
                child: const Text('Black',
                    style: TextStyle(color: Colors.black)), // Black text color
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll<Size>(Size(200, 50)),
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.95)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
      onPressed: () async {
        await _showOptionsDialog();

        if (selectedOption != null) {
          if (widget.choice == 1) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(1, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(1, 1000),
                ),
              );
            }
          } else if (widget.choice == 2) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(2, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(2, 1000),
                ),
              );
            }
          } else if (widget.choice == 3) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(3, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(3, 1000),
                ),
              );
            }
          } else if (widget.choice == 4) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(4, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(4, 1000),
                ),
              );
            }
          } else if (widget.choice == 5) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(5, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(5, 1000),
                ),
              );
            }
          } else if (widget.choice == 6) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(6, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(6, 1000),
                ),
              );
            }
          } else if (widget.choice == 7) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(7, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(7, 1000),
                ),
              );
            }
          } else if (widget.choice == 8) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(8, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(8, 1000),
                ),
              );
            }
          } else if (widget.choice == 9) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(9, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(9, 1000),
                ),
              );
            }
          } else if (widget.choice == 10) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(12, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(12, 1000),
                ),
              );
            }
          } else if (widget.choice == 11) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(11, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(11, 1000),
                ),
              );
            }
          } else if (widget.choice == 12) {
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(12, 1000),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(12, 1000),
                ),
              );
            }
          } else if (widget.choice == 13) {
            // Handle the selected option
            if (selectedOption == 'Random') {
              // Handle the random option
            } else if (selectedOption == 'White') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Gamestart(13, 1200),
                ),
              );
            } else if (selectedOption == 'Black') {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GamestartBlk(13, 1200),
                ),
              );
            }
          }
        }
      },
      child: Text(
        widget.text1,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Young_Serif',
        ),
        textScaleFactor: 1,
      ),
    );
  }
}
