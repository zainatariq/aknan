// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../models/req/get_chat_msgs_req_model.dart';
// import '../models/req/send_msg_req_model.dart';
// import '../models/res/msg_chat_res_model_item.dart';
// import '../pagienate-use-cases/get_chat_msgs_use_case.dart';
// import '../repository/chat_repo.dart';

// class ChatController extends Cubit<ChatState> {
//   final ChatRepo chatRepo;

//   ChatController({required this.chatRepo});

//   String? orderId;

//   String? chatId;

//   List<String> userType = ['customer', 'admin'];

//   int _userTypeIndex = 0;
//   bool get isOrderType => _userTypeIndex == 0;

//   int get userTypeIndex => _userTypeIndex;

//   void setUserTypeIndex(int index) {
//     _userTypeIndex = index;
//     update();
//   }

//   void toNewChat(
//     String orderIdp,
//   ) {
//     setUserTypeIndex(0);

//     orderId.value = orderIdp;
//     canChat.value = true;
//     // Future.delayed(const Duration(seconds: 1));
//     Get.put(
//       PaginateChatMsgsController(
//         GetChatMsgsUseCase(
//           GetChatMsgsReqModel(
//             1,
//             // chatId: chatId.value,
//             orderId: orderId.value,
//           ),
//         ),
//       ),
//     );
//     update();
//     refresh();
//     // paginateChatMsgsController = Get.find<PaginateChatMsgsController>();
//   }

//   File? pickedImageFile;

//   bool get canShowTextFelid => (pickedImageFile == null);

//   setChatId(String? id) {
//     chatId = id;

//     // Get.put(
//     //   PaginateChatMsgsController(
//     //     GetChatMsgsUseCase(
//     //       GetChatMsgsReqModel(
//     //         1,
//     //         chatId: chatId.value,
//     //         // orderId: orderId.value,
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }

//   clearData() async {
//     chatId = null;
//     orderId = null;
//     // await Get.delete<PaginateChatMsgsController>();
//   }
//   // FilePickerResult? _otherFile;
//   // FilePickerResult? get otherFile => _otherFile;

//   // File? _file;
//   // PlatformFile? objFile;
//   // File? get file=> _file;

//   // List<MultipartBody> _selectedImageList = [];
//   // List<MultipartBody> get selectedImageList => _selectedImageList;

//   // final List<dynamic> _conversationList=[];
//   // List<dynamic> get conversationList => _conversationList;

//   // final bool _paginationLoading = true;
//   // bool get paginationLoading => _paginationLoading;

//   // int? _messagePageSize;
//   // final int _messageOffset = 1;
//   // int? get messagePageSize => _messagePageSize;
//   // int? get messageOffset => _messageOffset;

//   // int? _pageSize;
//   // final int _offset = 1;
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//   // final String _name='';
//   // String get name => _name;
//   // final String _image='';
//   // String get image => _image;

//   // int? get pageSize => _pageSize;
//   // int? get offset => _offset;

//   var conversationController = TextEditingController();
//   final GlobalKey<FormState> conversationKey = GlobalKey<FormState>();

//   bool canChat = false;
//   // PaginateChatMsgsController? paginateChatMsgsController;

//   // setCanShat(bool state ,String id) async {
//   //   canChat = state;
//   //   await Future.delayed(const Duration(milliseconds: 300));
//   //   update(['canChat-$id']);
//   // }

//   void addMsgOnSpotChat(Map data) {
//     if (!data.containsKey("data")) {
//       data = {"data": data};
//     }

//     // var controller = Get.find<PaginateChatMsgsController>();

//     MsgChatResModel msg;
//     if (data['data']['message'] is String) {
//       msg = MsgChatResModel.fromSocketMap(
//         jsonDecode(data['data']['message']),
//       );
//     } else {
//       msg = MsgChatResModel.fromSocketMap(data['data']['message']);
//     }
//     // controller.items.insert(0, msg);
//     // controller.update();
//   }

//   void initChat() async {
//     conversationController.text = '';
//     _isLoading = false;
//     pickedImageFile = null;
//     if (!socketIsConnected()) {
//       initializeSocket(
//         onConnect: startListenOnNotification,
//         onDisconnect: (socket) {
//           stopListenOnNotification();
//         },
//       );
//       connectSocket();
//     } else {
//       startListenOnNotification();
//     }
//     await Future.delayed(const Duration(seconds: 1));
//     // paginateChatMsgsController = Get.find<PaginateChatMsgsController>();
//   }

//   void stopListenOnNotification() =>
//       unsubscribeFromEvent("user-notification.${user!.id}");

//   startListenOnNotification() {
//     sendSocketEvent("user_id", "${user!.id}");
//     subscribeToEvent("user-notification.${user!.id}", (data) {
//       if (kDebugMode) {
//         print(" received data $data  $tag ");
//       }

//       if (true) {
//         addMsgOnSpotChat(data);
//       }
//     });
//   }

//   /*
  
//   void initChat() async {
//     conversationController.text = '';
//     isLoading(false);
//     pickedImageFile.value = null;
//     initializeSocket(
//       onConnect: () {
//         sendMassage(["driver_id", "${user!.id}"]);
//         subscribeToEvent("driver-notification.${user!.id}", (data) {
//           if (kDebugMode) {
//             print(" received data $data  $tag ");
//           }

//           var msg = MsgChatResModelItem.fromSocketMap(data['data']['message']);
//           // print(" msg ::: ${msg.toString()} ");
//           var controller = Get.find<PaginateChatMsgsController>();
//           controller.items.insert(0, msg);
//           controller.update();
//           controller.moveScrollToMaxScrollExtent();
//         });
//       },
//     );
//     connectSocket();
//     await Future.delayed(const Duration(seconds: 1));
//     if (chatId != null) {
//       paginateChatMsgsController = Get.find<PaginateChatMsgsController>();

//       // WidgetsBinding.instance.addPostFrameCallback(
//       //   (timeStamp) {
//       //     paginateChatMsgsController?.moveScrollToMaxScrollExtent();
//       //   },
//       // );
//     }
//   }

//    */

//   // void pickMultipleImage(bool isRemove,{int? index}) async {
//   //   if(isRemove) {
//   //     if(index != null){
//   //       pickedImageFiles!.removeAt(index);
//   //       _selectedImageList.removeAt(index);
//   //     }
//   //   }else {
//   //     pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
//   //     if (pickedImageFiles != null) {
//   //       for(int i =0; i< pickedImageFiles!.length; i++){
//   //         _selectedImageList.add(MultipartBody('files[$i]',pickedImageFiles![i]));
//   //       }
//   //     }
//   //   }
//   //   update();
//   // }

//   // void pickOtherFile(bool isRemove) async {
//   //   if(isRemove){
//   //     _otherFile=null;
//   //     _file = null;
//   //   }else{
//   //     _otherFile = (await FilePicker.platform.pickFiles(withReadStream: true))!;
//   //     if (_otherFile != null) {
//   //       objFile = _otherFile!.files.single;
//   //     }
//   //   }
//   //   update();
//   // }

//   // void removeFile() async {
//   //   _otherFile=null;
//   //   update();
//   // }

//   // cleanOldData(){
//   //   pickedImageFiles = [];
//   //   _selectedImageList = [];
//   //   _otherFile = null;
//   //   _file = null;
//   // }

//   ScrollController scrollController = ScrollController();

//   scrollToMax() {
//     scrollController.jumpTo(scrollController.position.maxScrollExtent);
//   }

// }
