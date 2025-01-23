import 'dart:io';

//import 'dart:convert';
void main(List<String> args) {
  if (args.length != 3) {
    print(
        "Uso: bulk_rename.exe  <directory_input> <file_csv> <directory_output>");
    return;
  }

  String directoryInput = args[0];
  String fileCsv = args[1];
  String directoryOutput = args[2];

  Directory(directoryOutput).createSync(recursive: true);

  // Legge il file CSV e carica i dati in una mappa
  Map<int, String> nomiFile = {};
  try {
    File(fileCsv).readAsLinesSync().forEach((line) {
      List<String> parts = line.split(';');
      if (parts.length >= 2) {
        try {
          int numero = int.parse(parts[0]);
          //print(numero);
          //List<String> nomeDescrizione = parts[1].split(';');
          //String nome =nomeDescrizione[0].trim() + "_" + nomeDescrizione[1].trim();
          String nome = parts[1].trim();
          //print(nome);
          nomiFile[numero] = nome;
          //print(nomiFile[numero]);
        } catch (e) {
          // Ignora la riga se la prima colonna non è un numero
          print(
              'Ignorata riga con valore non numerico nella prima colonna: $line');
        }
      } else {
        print('Ignorata riga con meno di due colonne: $line');
      }
    });
  } catch (e) {
    print("Errore durante la lettura del file CSV: $e");
    return;
  }

  // Scansiona la directory per trovare i file numerati
  Directory(directoryInput).listSync().forEach((file) {
    if (file is File) {
      //print(file.path);
      String? fileName;
      if (Platform.isWindows) {
        fileName = file.path.split('\\').last;
      } else {
        fileName = file.path.split('/').last;
      }
      RegExp regExp = RegExp(r'^(\d+)');
      Match? match = regExp.firstMatch(fileName);
      if (match != null) {
        int numeroFile = int.parse(match.group(1)!);
        if (nomiFile.containsKey(numeroFile)) {
          // Rinomina il file
          String estensione = fileName.split('.').last;
          String nuovoNome = '${nomiFile[numeroFile]}.${estensione}';
          try {
            // File(file.path).renameSync('$directoryInput/$nuovoNome');
            // print('Rinominato $fileName in $nuovoNome');
            File(file.path).copySync('$directoryOutput/$nuovoNome');
            print('Copiato $fileName in $nuovoNome');
          } catch (e) {
            //print('Errore durante il rinominamento di $fileName: $e');
            print('Errore durante la copia di $fileName: $e');
          }
        }
      }
    }
  });
}
