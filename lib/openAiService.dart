import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled/secret.dart';

class OpenAIService{
  static final List<Map<String, String>> messages = [];

  static Future<String> chatGptApi(String prompt) async{
    // return "K this is chat gpt response for your qn";
   /* return '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquet elit nec felis dictum, at sollicitudin nisi aliquet. Proin sed tortor pretium, consequat nisi at, euismod velit. Fusce quis risus et ipsum finibus elementum. Quisque nec diam quis erat feugiat dignissim. Sed auctor bibendum justo, vitae tempor mauris finibus ut. Nam volutpat euismod urna, at viverra ligula eleifend eget. In vel interdum justo. Ut nec nisi tortor. Nam auctor justo quis facilisis venenatis. In lacinia magna eu quam lacinia, et vestibulum mauris egestas. Aliquam erat volutpat. Maecenas gravida orci et turpis interdum, sit amet tincidunt enim malesuada. Vivamus nec est velit. Suspendisse sem ipsum, mattis ut gravida id, fermentum eu metus.

Duis tincidunt ante justo, sit amet tristique arcu aliquam ut. Aenean sollicitudin mauris at ligula sagittis, in tempor metus mattis. Suspendisse sed urna vestibulum, facilisis metus non, consequat turpis. Maecenas rutrum interdum iaculis. Phasellus fermentum nulla sed tortor dignissim faucibus. Cras vulputate sem in mauris pellentesque, eu pharetra erat hendrerit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam feugiat, lectus sed varius posuere, turpis mi congue mauris, a lacinia leo enim et massa. Fusce auctor ullamcorper eros ac malesuada.

Praesent id odio risus. Mauris venenatis metus in risus suscipit volutpat. Suspendisse potenti. Maecenas cursus quam et felis volutpat, vitae feugiat lectus consequat. Donec at odio eros. Nunc nec ligula vel justo consequat porttitor. Phasellus laoreet, felis sed mattis auctor, lorem mi tempor turpis, in tincidunt urna ex id lorem. Aliquam vel dictum justo. In auctor leo ac ligula dictum, at dignissim nunc suscipit. Curabitur in ante eu tellus dictum suscipit eu at arcu. Nunc vel tellus vitae sapien pulvinar sollicitudin. Proin cursus turpis ut volutpat commodo.

Nullam convallis varius nunc nec blandit. Sed euismod tristique ligula, non aliquet arcu cursus id. Pellentesque iaculis odio et metus sollicitudin, at lacinia metus malesuada. Curabitur vulputate, purus eget vehicula consequat, enim purus euismod ante, ut tristique lorem enim eget metus. Curabitur mattis elit sed ex aliquet, in bibendum turpis finibus. Aenean pellentesque risus sed erat convallis elementum. Aliquam interdum pellentesque neque, et ultrices mauris finibus at. Mauris eu mauris a enim malesuada congue vitae eu ipsum. Nunc faucibus cursus enim. Vestibulum elementum mi in velit rhoncus facilisis. Et'''
;*/
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
        jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
