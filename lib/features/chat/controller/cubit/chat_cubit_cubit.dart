import 'dart:convert';
import 'dart:io';

import 'package:aknan_user_app/features/authenticate/data/models/res-models/user_model.dart';
import 'package:aknan_user_app/features/authenticate/domain/use-cases/auth_cases.dart';
import 'package:aknan_user_app/features/chat/models/res/msg_chat_res_model_item.dart';
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/injection_container.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/localization/locale_keys.g.dart';
import 'package:aknan_user_app/mixins/socket_io_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:one_context/one_context.dart';

import '../../../../bases/pagination/state/pagination_bloc_state.dart';
import '../../../../bases/pagination/typedef/page_typedef.dart';
import '../../models/req/send_msg_req_model.dart';
import '../../repository/chat_repo.dart';

part 'chat_cubit_state.dart';
part 'chat_cubit_cubit.freezed.dart';

class ChatCubitCubit extends Cubit<ChatCubitState> with SocketIoMixin {
  UserAuthModel? userAuthModel;

  final ChatRepo chatRepo;
  ChatCubitCubit(
    this.chatRepo,
  ) : super(const ChatCubitState.initial()) {
    sl<AuthCases>().getUserData().then((value) {
      if (value != null) {
        userAuthModel = value;
      }
      return;
    });
  }

  String? orderId;

  String? chatId;

  bool canChat = false;

  setChatStatus(bool status) {
    canChat = status;
    emit(ChatCubitState.setChatStatus(status));
  }

  void toNewChat(
    String orderIdp,
  ) {
    orderId = orderIdp;
    canChat = true;
    // Future.delayed(const Duration(seconds: 1));

    // Get.put(
    //   PaginateChatMsgsController(
    //     GetChatMsgsUseCase(
    //       GetChatMsgsReqModel(
    //         1,
    //         // chatId: chatId.value,
    //         orderId: orderId,
    //       ),
    //     ),
    //   ),
    // );

    // paginateChatMsgsController = Get.find<PaginateChatMsgsController>();
  }

  File? pickedImageFile;

  bool get canShowTextFelid => (pickedImageFile == null);

  void pickImage(File? file) {
    if (file != null) {
      conversationController.text = "";
    }
    pickedImageFile = file;
    emit(ChatCubitState.pickImg(file));
  }

  var conversationController = TextEditingController();
  final GlobalKey<FormState> conversationKey = GlobalKey<FormState>();

  void addMsgOnSpotChat(Map data) {
    if (!data.containsKey("data")) {
      data = {"data": data};
    }

    MsgChatResModelItem msg;
    if (data['data']['message'] is String) {
      msg = MsgChatResModelItem.fromSingleMap(
        jsonDecode(data['data']['message']),
      );
    } else {
      msg = MsgChatResModelItem.fromSingleMap(data['data']['message']);
    }
    msg = msg.copyWith(
      maintenance: paginateGetChatMsgsController.items.first.maintenance,
      admin: paginateGetChatMsgsController.items.first.admin,
      user: paginateGetChatMsgsController.items.first.user,
    );
    paginateGetChatMsgsController.items.insert(
      0,
      msg,
    );
    paginateGetChatMsgsController
        .emitNewItemAdded(paginateGetChatMsgsController.items);
  }

  void initChat() async {
    conversationController.text = '';
    // _isLoading = false;
    pickedImageFile = null;
    if (!socketIsConnected()) {
      initializeSocket(
        onConnect: startListenOnNotification,
        onDisconnect: (socket) {
          stopListenOnNotification();
        },
      );
      connectSocket();
    } else {
      startListenOnNotification();
    }
    await Future.delayed(const Duration(seconds: 1));
    // paginateChatMsgsController = Get.find<PaginateChatMsgsController>();
  }

  void stopListenOnNotification() =>
      unsubscribeFromEvent("user-notification.${userAuthModel!.id}");

  startListenOnNotification() {
    sendSocketEvent("user_id", "${userAuthModel!.id}");
    subscribeToEvent("user-notification.${userAuthModel!.id}", (data) {
      if (kDebugMode) {
        print(" received data $data  $tag ");
      }

      if (true) {
        addMsgOnSpotChat(data);
      }
    });
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setIsLoading() {
    _isLoading = true;
    emit(const ChatCubitState.sendMsgLoading());
  }

  BuildContext? pgContext;

  PaginateGetChatMsgsController get paginateGetChatMsgsController =>
      BlocProvider.of<PaginateGetChatMsgsController>(pgContext!);

  sendMsg(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (validate(context)) {
      setIsLoading();
      SendMsgReqModel req = _getReqBody().getIdForChat(orderId: orderId);
      final state = await chatRepo.sendMsg(req);

      state.whenOrNull(
        success: (data) async {
          _isLoading = false;
          conversationController.clear();
          var msg = await req.toMsg(
            userAuthModel!,
            admin: data.data.first.admin,
            maintenance: data.data.first.maintenance,
          );
          paginateGetChatMsgsController.items.insert(0, msg);
          paginateGetChatMsgsController
              .emitNewItemAdded(paginateGetChatMsgsController.items);
          pickImage(null);
          setChatStatus(true);
          conversationController.clear();
          emit(const ChatCubitState.sendMsgSuccess());
        },
        error: (message, errorList) {
          _isLoading = false;
          emit(const ChatCubitState.sendMsgSuccess());
          context.showError(errorList?.first ?? message ?? "");
        },
      );
    }
  }

  SendMsgReqModel _getReqBody() {
    SendMsgReqModel req;
    if (pickedImageFile != null) {
      req = SendMsgReqModel(
        msg: pickedImageFile,
      );
    } else {
      req = SendMsgReqModel(
        msg: conversationController.text,
      );
    }
    return req;
  }

  bool validate(BuildContext context) {
    if (conversationController.text.trim().isNotEmpty ||
        pickedImageFile != null) {
      return true;
    } else {
      String msg = LocaleKeys.message_or_image_required.tre;
      context.showError(msg);
      return false;
    }
  }
}
