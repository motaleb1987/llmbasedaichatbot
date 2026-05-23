import 'package:llmbasedaichatbot/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.role, required super.text, required super.time});
  // Map kore MessageEntity class a input data pathano hoiteche.
  Map<String, String> toApiMap() => {'role': role, 'content': text};
}
