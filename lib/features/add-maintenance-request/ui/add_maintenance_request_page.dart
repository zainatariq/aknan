import 'package:aknan_user_app/helpers/button_styles.dart';
import 'package:one_context/one_context.dart';

import '../../../bases/base_state/base_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiselect/multiselect.dart';

import '../../../bases/base-models/base_id_value_model.dart';
import '../../../date_converter.dart';
import '../../../global/app-assets/assets.dart';
import '../../../helpers/navigation.dart';
import '../../../localization/change_language.dart';
import '../../../localization/locale_keys.g.dart';
import '../../../widgets/app_back_btn.dart';
import '../../../widgets/app_notification_widget.dart';
import '../../../widgets/app_page.dart';
import '../../../widgets/generic_dropdown.dart';
import '../cubit/cubit/add_maintenance_request_cubit.dart';
import '../model/req/post_maintenance_req_model.dart';

class AddMaintenanceRequestPage
    extends AppScaffold<AddMaintenanceRequestCubit> {
  final String id;
  final PostMaintenanceReqModel? req;
  const AddMaintenanceRequestPage({
    super.key,
    required this.id,
    this.req,
  });

  OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(OneContext.instance.context!).primaryColor,
          width: 2,
        ),
      );
  @override
  Widget build(BuildContext context) {
    cubit.initPage();
    return WillPopScope(
      onWillPop: () {
        cubit.initPage();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.request_maintenance.tre),
          leading: AppBackBtn(
            onTap: () {
              cubit.initPage();
              context.pop();
            },
          ),
          actions: const [AppNotificationWidget()],
        ),
        body: BlocBuilder<AddMaintenanceRequestNetCubit, ICubitState<dynamic>>(
          bloc: AddMaintenanceRequestNetCubit.instance,
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AddMaintenanceRequestCubit,
                      AddMaintenanceRequestState>(
                    bloc: AddMaintenanceRequestCubit.instance
                      ..maintenanceTypeId = id
                      ..makeEdit(req),
                    // ,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: DropDownMultiSelect<BaseIdNameModelString>(
                              onChanged: cubit.selectMalfunction,
                              menuItembuilder: (option) => Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                child: Text(
                                  option.value ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ),
                              options: cubit.allMalfunctions,
                              selectedValues: cubit.selectedMalfunctions,
                              selected_values_style:
                                  Theme.of(context).textTheme.headlineSmall!,
                              whenEmpty: LocaleKeys.malfunctions.tre,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          ...cubit.selectedMalfunctions.map((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 9,
                                ),
                                child: Text(e.value ?? ""),
                              )),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AddMaintenanceRequestCubit,
                      AddMaintenanceRequestState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GenericDropdown<BaseIdNameModelString>(
                            items: cubit.allTypesOfElevator,
                            hintText: LocaleKeys.types_of_elevators.tre,
                            selectedValue: cubit.selectedTypesOfElevator,
                            
                            onChanged: cubit.selectTypeOfElevator,
                            prefixIconPath:
                                Assets.imagesSvgsSignificonHomeActive,
                            itemToString: (p0) {
                              return p0.value;
                            },
                          ),
                          const SizedBox(height: 5),
                          // ...cubit.selectedTypesOfElevator.map((e) => ),
                          if (cubit.selectedTypesOfElevator != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 9),
                              child: Text(
                                  cubit.selectedTypesOfElevator?.value ?? ""),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AddMaintenanceRequestCubit,
                      AddMaintenanceRequestState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              cubit.selectDateAndTime(context);
                            },
                            child: Text(
                              LocaleKeys.time_and_date.tre,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          if (cubit.selectedDate != null)
                            Row(
                              children: [
                                Text(
                                  DateConverter.convertDateTimeToStringDate(
                                      cubit.selectedDate),
                                  // style:
                                  //     Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  DateConverter.convertDateTimeToHMa(
                                      cubit.selectedDate!),
                                  // style:
                                  //     Theme.of(context).textTheme.headlineSmall,
                                )
                              ],
                            ),
                          if (cubit.selectedDate != null)
                            const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<AddMaintenanceRequestCubit,
                      AddMaintenanceRequestState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (cubit.postReq?.elevatorCode != null) ...{
                            const SizedBox(height: 20),
                            Text(
                              LocaleKeys.elevator_code.tre,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 20),
                            Text(cubit.postReq?.elevatorCode ?? ""),
                          },
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    LocaleKeys.comments.tre,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: cubit.commentController,
                    maxLines: null,
                    minLines: 6,
                    decoration: InputDecoration(
                      // hintText: LocaleKeys.notes.tre,
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AddMaintenanceRequestCubit,
                      AddMaintenanceRequestState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return Visibility(
                        visible: cubit.isEdit == null || cubit.isEdit == false,
                        child: Center(
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 120, vertical: 12),
                                  ),
                                ),
                            onPressed: () {
                              cubit.submitRequest(context);
                            },
                            child: Text(
                              LocaleKeys.submit.tre,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style
                                    ?.textStyle
                                    ?.resolve({})?.color,
                                fontSize: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style
                                    ?.textStyle
                                    ?.resolve({})?.fontSize,
                                fontWeight: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style
                                    ?.textStyle
                                    ?.resolve({})?.fontWeight,
                                fontFamily: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style
                                    ?.textStyle
                                    ?.resolve({})?.fontFamily,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AddMaintenanceRequestCubit,
                      AddMaintenanceRequestState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return Visibility(
                        visible: cubit.isEdit == true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cubit.deleteRequest(context);
                                    },
                                    style: const ButtonStyle().white.copyWith(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 20,
                                            ),
                                          ),
                                        ),
                                    child: Text(
                                      LocaleKeys.delete.tre,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cubit.submitRequest(context);
                                    },
                                    style: const ButtonStyle().blue.copyWith(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 20,
                                            ),
                                          ),
                                        ),
                                    child: Text(
                                      LocaleKeys.edit.tre,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
