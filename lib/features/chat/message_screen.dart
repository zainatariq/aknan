import 'package:aknan_user_app/features/chat/repository/chat_repo.dart';
import 'package:aknan_user_app/global/app-assets/assets.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/widgets/app_back_btn.dart';

import '../../bases/pagination/state/pagination_bloc_state.dart';
import '../../bases/pagination/typedef/page_typedef.dart';
import '../../bases/pagination/widgets/paginations_widgets.dart';
import '../../localization/locale_keys.g.dart';
import '../../widgets/pick_img_widget.dart';
import 'controller/cubit/chat_cubit_cubit.dart';
import '../../helpers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/custom_no_data.dart';
import 'models/req/get_chat_msgs_req_model.dart';
import 'pagienate-use-cases/get_chat_msgs_use_case.dart';
import 'widget/message_bubble.dart';

class MessageScreen extends StatelessWidget {
  final String? chatId;
  final String? maintenanceId;
  const MessageScreen({
    super.key,
    this.chatId,
    this.maintenanceId,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // if (cubit == null) {
        //   cubit.disconnectSocket();
        // } else {
        //   cubit.stopListenOnNotification();
        // }
        // cubit.clearData();
        context.pop();
        return Future.value(false);
      },
      child: BlocProvider(
        create: (context) =>
            ChatCubitCubit(ChatRepo())..orderId = maintenanceId,
        child: BlocBuilder<ChatCubitCubit, ChatCubitState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<ChatCubitCubit>(context);
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(LocaleKeys.messages.tre),
                  leading: const AppBackBtn(),
                ),
                bottomSheet: Visibility(
                  visible: cubit.canChat,
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 15,
                          ),
                          decoration: const BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Theme.of(context)
                            //         .hintColor
                            //         .withOpacity(.25),
                            //     blurRadius: 5,
                            //     spreadRadius: 5,
                            //     offset: const Offset(.5, .5),
                            //   ),
                            // ],
                            color: Color(0xffF4F1EC),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: Form(
                            key: cubit.conversationKey,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Row(
                                  mainAxisAlignment: cubit.canShowTextFelid
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.center,
                                  children: [
                                    ImagePick(
                                      selectedFile: cubit.pickedImageFile,
                                      width:
                                          (cubit.canShowTextFelid ? 100 : 300) /
                                              2,
                                      hight:
                                          (cubit.canShowTextFelid ? 100 : 300) /
                                              2,
                                      deleteImg: () => cubit.pickImage(null),
                                      onSelectImg: cubit.pickImage,
                                    ),
                                    Visibility(
                                      visible: cubit.isLoading,
                                      // visible: false,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        height: 20,
                                        width: 40,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,

                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: !cubit.isLoading,
                                      child: InkWell(
                                        onTap: () => cubit.sendMsg(context),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20
                                              // Dimensions.paddingSizeSmall,
                                              ),
                                          child: Image.asset(
                                            Assets.imagesPngsSendMsg,
                                            width: 30,
                                            height: 30,
                                            //color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Visibility(
                                  visible: cubit.pickedImageFile == null,
                                  child: Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: TextFormField(
                                        readOnly: cubit.pickedImageFile != null,
                                        controller:
                                            cubit.conversationController,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        style: TextStyle(
                                          // fontSize: Dimensions.fontSizeLarge,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color!
                                              .withOpacity(0.8),
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        textInputAction: TextInputAction.send,
                                        // textDirection: ,
                                        enabled: cubit.canShowTextFelid,
                                        onFieldSubmitted: (value) =>
                                            cubit.sendMsg(context),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: const Color(0xffF4F1EC),
                                          filled: true,
                                          hintText:
                                              cubit.pickedImageFile != null
                                                  ? ""
                                                  : LocaleKeys.message.tre,
                                          hintTextDirection: TextDirection.ltr,
                                          hintStyle: TextStyle(
                                            color: Theme.of(context)
                                                .bottomNavigationBarTheme
                                                .backgroundColor!
                                                .withOpacity(0.8),
                                            fontSize: 16,
                                          ),
                                        ),
                                        onChanged: (String newText) {
                                          if (newText.isNotEmpty) {
                                            cubit.pickImage(null);
                                          }
                                        },
                                        
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
                // resizeToAvoidBottomInset: false,
                // backgroundColor: Colors.white,
                body: Column(
                  children: [
                    // CustomAppBar(
                    //   title: Strings.message.tr,
                    //   onBackPressed: () {
                    //     if (cubit..value == null) {
                    //       cubit.disconnectSocket();
                    //     } else {
                    //       cubit.stopListenOnNotification();
                    //     }
                    //     cubit.clearData();
                    //     Get.back();
                    //   },
                    // ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 100),
                        child: SizedBox(
                          height:
                              (MediaQuery.sizeOf(context).height / 5) * 3.5 -
                                  MediaQuery.of(context).viewInsets.bottom,
                          child: BlocProvider(
                            create: (context) => PaginateGetChatMsgsController(
                              GetChatMsgsUseCase(
                                GetChatMsgsReqModel(1, orderId: maintenanceId),
                                context,
                              ),
                            )..startInitData(),
                            child: BlocBuilder<PaginateGetChatMsgsController,
                                PaginationBlocState>(
                              builder: (context, state) {
                                cubit.pgContext = context;
                                return PaginateGetChatMsgsView(
                                  listPadding: const EdgeInsets.only(
                                      right: 30, left: 30),
                                  child: (entity) =>
                                      ConversationBubble(data: entity),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    // K.sizedBoxH0,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
