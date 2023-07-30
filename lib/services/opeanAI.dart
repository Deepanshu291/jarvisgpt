// curl https://api.openai.com/v1/chat/completions \
//   -H "Content-Type: application/json" \
//   -H "Authorization: Bearer $OPENAI_API_KEY" \
//   -d '{
//      "model": "gpt-3.5-turbo",
//      "messages": [{"role": "user", "content": "Say this is a test!"}],
//      "temperature": 0.7
//    }'
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jarvisgpt/env/apikey.dart';

class OpenAPIService {
  Future<String> GetPrompt(String prompt) async {
    try {
      var uri = Uri.parse('https://api.openai.com/v1/chat/completions');
      final res = await http.post(uri,
          headers: {
            "Content-Type": 'application/json',
            "Authorization": 'Bearer $OpenApiKey'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "user", "content": prompt,
              }
            ],
          }));
      // print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        // print('AI : $content');
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
