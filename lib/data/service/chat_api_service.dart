import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constans/app_strings.dart';
import '../model/message_model.dart';

class ChatApiService {
  Future<String> fetchAssistantReply(List<MessageModel> messages) async {
    print('[Chat] Sending request to: ${AppStrings.baseUrl}/chat/completions');
    print('[Chat] Model: ${AppStrings.model}');
    print('[Chat] Message count: ${messages.length}');

    final response = await http
        .post(
          Uri.parse('${AppStrings.baseUrl}/chat/completions'),
          headers: {
            'Authorization': 'Bearer ${AppStrings.apiKey}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'model': AppStrings.model,
            'max_tokens': 1024,
            'message': [
              {"role": "system", "content": AppStrings.systemPrompt},
              ...messages.map((e) => e.toApiMap()),
            ],
          }),
        )
        .timeout(Duration(seconds: 40));


    print('[Chat] Status code: ${response.statusCode}');
    print('[Chat] Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch assistant reply : ${response.statusCode}',
      );
    }
    final data = jsonDecode(response.body);
    return (data['choices'][0]['message']['content'] as String).trim();
  }
}
