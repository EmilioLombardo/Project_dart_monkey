import 'package:my_cli_app/my_cli_app.dart' as my_cli_app;

void main(List<String> arguments) {
  int num = my_cli_app.getIntFromUser();
  print('You typed: $num');
}
