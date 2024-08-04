// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../authenticate/data/models/res-models/user_model.dart';
import '../../constants/chat_constant.dart';
import '../res/msg_chat_res_model_item.dart';

enum MsgType {
  text,
  image,
  file,
  voice,
}

//  chat_type: "order",
enum ChatType { order, admin }

class SendMsgReqModel {
  String? orderId;
  String? chatId;
  MsgType? msgType;
  dynamic msg;
  ChatType? chatType;
  SendMsgReqModel({
    this.orderId,
    this.chatId,
    this.chatType = ChatType.order,
    this.msgType,
    required this.msg,
  }) {
    if (msg is File) {
      msgType = MsgType.image;
    } else {
      msgType = MsgType.text;
    }
  }

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      if (chatType == ChatType.order && orderId != null)
        'maintenance_id': orderId,
      if (chatId != null) 'chat_id': chatId,
      "chat_type": chatType!.name,
      ...{
        if (msg is File) ...{
          'msg': await MultipartFile.fromFile((msg as File).path),
          'msg_type': MsgType.image.name,
        } else ...{
          'msg': msg,
          'msg_type': MsgType.text.name,
        }
      }
    };
  }

  getIdForChat({
    String? orderId,
    String? chatId,
  }) {
    if (orderId != null) {
      this.orderId = orderId;
      // this.chatId = null;
      chatType = ChatType.order;
    } else {
      chatType = ChatType.admin;
      this.chatId = chatId;
    }
    return this;
  }

  Future<MsgChatResModelItem> toMsg(
    UserAuthModel user, {
    Admin? admin,
    Maintenance? maintenance,
  }) async {
    return MsgChatResModelItem(
      id: "",
      admin: admin,
      maintenance: maintenance,
      user: await User.fromLUserAuthModel(),
  
      msgType: msgType!.name,
      lastMsg: msg,
      createdAt: DateTime.now(),
      senderType: ChatConstant.who,
    );
  }
}
