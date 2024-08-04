
import 'mockup/mockup_section.dart';
import 'widgets/chucker_tile.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/developer_cubit.dart';

class DeveloperSettingsScreen extends StatelessWidget {
  const DeveloperSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final developerCubit = context.watch<DeveloperCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'developer_options'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MockupSection(),
              // ListTile(
              //   leading: const Icon(Icons.storage),
              //   onTap: () async => await Modular.to.pushNamed(
              //     StorageModule.storageRoute,
              //   ),
              //   title: Text(
              //     'storage_ui'.translate(context),
              //   ),
              // ),
              // ListTile(
              //   leading: const Icon(Icons.hive),
              //   onTap: () async => await Modular.to.pushNamed(
              //     HiveModule.hiveRoute,
              //   ),
              //   title: Text(
              //     'hive_ui'.translate(context),
              //   ),
              // ),
              const ChuckerTile(),
              ListTile(
                leading: const Icon(Icons.report),
                onTap: ChuckerFlutter.showChuckerScreen,
                title: Text(
                  'chucker'.tr(),
                ),
              ),
              // ListTile(
              //   title: Text('change_base_url'.tr()),
              //   trailing: TextButton(
              //     onPressed: () async {
              //       final altBaseUrl = await showDialog(
              //         context: context,
              //         builder: (_) => const ChangeBaseUrlDialog(),
              //       );
              //       if (altBaseUrl != null) {
              //         developerCubit.changeBaseUrl(altBaseUrl);
              //       }
              //     },
              //     child: Text('change'.translate(context)),
              //   ),
              // ),
              
            ],
          ),
        ),
      ),
    );
  }
}
