import 'package:args/args.dart';
import 'package:folder_cli/folder_cli.dart' as folder_cli;

void main(List<String> arguments) async {
  final parser = ArgParser();

  parser.addOption('command', abbr: 'c', help: 'This command to run.');
  parser.addOption('argument',
      abbr: 'a', help: 'The argument to pass to the command.');

  final results = parser.parse(arguments);
  print(results['command']);
  // Run the command.
  switch (results['command']) {
    case 'create':
      folder_cli.createFolderStructureAndFiles(results['argument']);

      // Create a new Flutter project.
      break;
    case 'build':
      // Build the Flutter project.
      break;
    case 'run':
      // Run the Flutter project.
      break;
    default:
      // Print an error message.
      print('Invalid command.');
      break;
  }

  print('Hello world: ${folder_cli.calculate()}!');
}
