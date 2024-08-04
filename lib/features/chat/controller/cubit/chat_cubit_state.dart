part of 'chat_cubit_cubit.dart';

@freezed
class ChatCubitState with _$ChatCubitState {
  const factory ChatCubitState.initial() = Initial;
  const factory ChatCubitState.setChatStatus(bool status) = _SetChatStatus;

  const factory ChatCubitState.handelNewChat() = _HandelNewChat;
  const factory ChatCubitState.pickImg(File? file) = PickImg;



  const factory ChatCubitState.sendMsg() = _SendMsg;
  const factory ChatCubitState.sendMsgSuccess() = _SendMsgSuccess;
  const factory ChatCubitState.sendMsgFailed() = _SendMsgFailed;
  const factory ChatCubitState.sendMsgLoading() = _SendMsgLoading;
  const factory ChatCubitState.loadMsgs() = LoadMsgs;





}
