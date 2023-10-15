import 'dart:io';

Future<void> compileStockfish() async {
  // Navigate to the directory where Stockfish source code is located
  final stockfishDirectory = Directory('../stockfish/src');
  if (!stockfishDirectory.existsSync()) {
    print('Error: Stockfish directory not found.');
    return;
  }

  // Run the compilation commands (replace these with your actual compilation commands)
  final result = await Process.run(
    'make',
    ['-j', 'profile-build', 'ARCH=x86-64-bmi2'],
    /*[
      '-o',
      'stockfish',
      'stockfish.cpp',
      // Add other source files and compilation flags as needed
    ],*/
    workingDirectory: stockfishDirectory.path,
  );

  if (result.exitCode == 0) {
    print('Stockfish compiled successfully.');
  } else {
    print('Error compiling Stockfish: ${result.stderr}');
  }
}

void main() {
  compileStockfish();
}
