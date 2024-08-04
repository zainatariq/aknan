import 'dart:io';

import 'package:flutter/material.dart';

import '../../../bases/pagination/widgets/paginations_widgets.dart';
import '../../../date_converter.dart';
import '../../../widgets/custom_image.dart';
import '../models/req/send_msg_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class ConversationBubble extends PaginationViewItem<MsgChatResModelItem> {
  const ConversationBubble({super.key, required super.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          !data.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: data.isMe
              ? const EdgeInsets.fromLTRB(15, 5, 5, 5)
              : const EdgeInsets.fromLTRB(5, 5, 15, 5),
          child: Column(
            crossAxisAlignment:
                data.isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: !data.isMe
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: data.isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              // color: data.isMe
                              //     ? Theme.of(context).primaryColor
                              //     : Theme.of(context).hintColor,
                              color: const Color(0xffF4F1EC),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: data.msgType == MsgType.text.name
                                  ? Text(
                                      data.lastMsg ?? "",
                                      style: TextStyle(
                                        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                                      ),
                                    )
                                  : data.lastMsg is String &&
                                          data.msgType == MsgType.image.name
                                      ? CustomImage(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.contain,
                                          image: data.lastMsg ?? "",
                                        )
                                      : Image.file(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.contain,
                                          File((data.lastMsg as File).path),
                                        ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: !data.isMe
              ? const EdgeInsets.fromLTRB(5, 0, 15, 5)
              : const EdgeInsets.fromLTRB(15, 0, 5, 5),
          child: Text(
            DateConverter.fromNow(data.createdAt.toString()),
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 9,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
