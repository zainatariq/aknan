import '../../../features/chat/models/res/msg_chat_res_model_item.dart';
import '../../../features/chat/pagienate-use-cases/get_chat_msgs_use_case.dart';
import '../../../features/chat/pagienate-use-cases/get_list_of_chats_use_case.dart';
import '../../../features/chat/widget/message_bubble.dart';
import '../../../features/chat/widget/message_item.dart';
import '../../../features/notification/pagnaintion/use-case/get_notifications_use_case.dart';

import '../../../features/add-maintenance-request/model/user_elevators_list_res_model.dart';
import '../../../features/elevators-by-id/pagnaintion/model/get_elevators_by_id_req_model.dart';
import '../../../features/elevators-by-id/pagnaintion/use-case/get_elevators_by_id_use_case.dart';

import '../../../features/elevators-by-id/ui/elevators_by_id_screen.dart';
import '../../../features/home-app/pages/profile/pagenate/use-case/get_user_electors_use_case.dart';
import '../../../features/home-app/pages/profile/ui/widget/elevator_widget.dart';
import '../../../features/maintenance-work/pagnaintion/model/res/maintenance_work_res_model.dart';
import '../../../features/maintenance-work/pagnaintion/usa-case/n.dart';
import '../../../features/maintenance-work/ui/widget/row_item.dart';
import '../../../features/notification/model/notification_model.dart';
import '../../../features/notification/ui/notification_screen.dart';
import '../../base-models/elevator_model.dart';
import '../controller/pagination_controller.dart';
import '../use-case/main_paginate_list_use_case.dart';
import '../widgets/paginations_widgets.dart';

typedef PC<T extends MainPaginateListUseCase, E> = PaginationController<T, E>;

// example
// typedef PaginateTripHistoryController<T extends MainPaginateListUseCase, E>
//     = PC<GetHistoryTripsUseCase, HistoryData>;
// typedef PaginateTripHistoryView = PaginationListViewInTabBar<
//     GetHistoryTripsUseCase, HistoryData, ActivityItemView>;
// PaginateTripHistory

typedef PaginateGetElevatorsByIdController<T extends MainPaginateListUseCase, E>
    = PC<GetElevatorsByIdUseCase, ElevatorModel>;

typedef PaginateGetElevatorsByIdView = PaginationListViewInTabBar<
    GetElevatorsByIdUseCase, ElevatorModel, ElevatorsByIdItemWidget>;

typedef PaginateGetNonfictionController<T extends MainPaginateListUseCase, E>
    = PC<GetNotificationsUseCase, NotificationModel>;

typedef PaginateGetNonfictionView = PaginationListViewInTabBar<
    GetNotificationsUseCase, NotificationModel, NotificationItemWidget>;




    
typedef PaginateGetUserElectorsController<T extends MainPaginateListUseCase, E>
    = PC<GetUserElectorsUseCase, ElevatorModelInList>;

typedef PaginateGetUserElectorsView = PaginationListViewInTabBar<
    GetUserElectorsUseCase, ElevatorModelInList, ElevatorWidget>;

    
typedef PaginateGetMaintenanceWorkController<T extends MainPaginateListUseCase, E>
    = PC<GetMaintenanceWorkUseCase, MaintenanceWorkResData>;

typedef PaginateGetMaintenanceWorkView = PaginationListViewInTabBar<
  GetMaintenanceWorkUseCase, MaintenanceWorkResData, RowItem>;



typedef PaginateGetListOfChatsController<T extends MainPaginateListUseCase, E>
    = PC<GetListOfChatsUseCase, MsgChatResModelItem>;

typedef PaginateGetListOfChatsView = PaginationListViewInTabBar<
  GetListOfChatsUseCase, MsgChatResModelItem, MessageItem>;


  
typedef PaginateGetChatMsgsController<T extends MainPaginateListUseCase, E>
    = PC<GetChatMsgsUseCase, MsgChatResModelItem>;

typedef PaginateGetChatMsgsView = PaginationChatListView<
  GetChatMsgsUseCase, MsgChatResModelItem, ConversationBubble>;
