import 'dart:io';

int getIntFromUser({prompt="Type an integer: "}) {
    int number = 0;
    bool valid = false;
    int i = 0;
    while (!valid && i++ < 25) { 
        stdout.write(prompt);
        String? userInput = stdin.readLineSync();
        try {
            number = int.parse(userInput ?? "");
            valid = true;
        } on FormatException {
            print("Invalid input.");
        }
    }
    return number;
}
