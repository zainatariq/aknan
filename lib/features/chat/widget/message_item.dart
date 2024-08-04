import 'package:aknan_user_app/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bases/pagination/widgets/paginations_widgets.dart';
import '../../../widgets/custom_image.dart';
import '../controller/chat_controller.dart';
import '../message_screen.dart';
import '../models/req/send_msg_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class MessageItem extends PaginationViewItem<MsgChatResModelItem> {
  final Function()? onTap;
  const MessageItem({super.key, required this.onTap, required super.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2)),
            color:
                //  isRead
                //     ?

                //     Theme.of(context).colorScheme.primary.withOpacity(.1)
                //     :
                Theme.of(context).cardColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomImage(
                  height: 35,
                  width: 35,
                  image: data.isMe ? "" : data.admin?.img ?? "",
                ),
              ),
              const SizedBox(
                // width: Dimensions.paddingSizeSmall,
                width: 10,
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      data.isMe ? data.user!.name : data.admin?.name ?? "",
                      // style: textBold.copyWith(
                      //   fontSize: Dimensions.fontSizeDefault,
                      //   color: Theme.of(context).primaryColor,
                      // ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data.msgType == MsgType.text.name
                                ? data.lastMsg!
                                : MsgType.image.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: data.msgType == MsgType.text.name
                                  ? Theme.of(context).hintColor
                                  : Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.6),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateConverter.fromNow(data.createdAt.toString()),
                          textDirection: TextDirection.ltr,
                          // style: textRegular.copyWith(
                          //   fontSize: Dimensions.fontSizeExtraSmall,
                          //   color: Theme.of(context).primaryColor,
                          // ),
                        )
                      ],
                    )
                  ])),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
