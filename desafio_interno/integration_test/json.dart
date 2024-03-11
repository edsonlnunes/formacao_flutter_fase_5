import 'dart:convert';
import 'package:http/http.dart' as http;

var uid = "TROCANOSHUID";

class TestResult {
  String title;
  bool approved;

  TestResult({
    required this.title,
    required this.approved,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'approved': approved,
      };
}

void enviarDadosComoJson(List<TestResult> testResults) async {
  var url = Uri.parse(
    'https://growacademy-api-dev.herokuapp.com/api/auto-corrections/${uid}',
  );

  Map<String, dynamic> data = {
    'results': testResults.map((e) => e.toMap()).toList(),
  };

  String jsonData = jsonEncode(data);

  var response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonData,
  );

  if (response.statusCode == 200) {
    print('Put enviado com sucesso!');
    print(jsonData);
  } else {
    print('Falha ao enviar o put. Código de status: ${response.statusCode}');
  }
}
