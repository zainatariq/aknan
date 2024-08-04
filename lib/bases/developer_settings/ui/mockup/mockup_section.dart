
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/developer_cubit.dart';

class MockupSection extends StatelessWidget {
  const MockupSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final developerCubit = context.watch<DeveloperCubit>();
    const endpoints = [
      // AuthConstant.loginEndpoint,
      // AuthConstant.forgetPasswordEndpoint,
      // ChannelsConstants.channelEndpoint,
      // CurrencyConstants.currencyEndpoint,
      // TerminalTypesConstants.terminalTypesEndpoint,
      // TransactionConstant.transactionDetailsWithStatisticsEndpoint,
      // TransactionConstant.transactionStatisticsEndpoint,
      // TransactionConstant.transactionSummaryEndpoint,
      // MerchantRequestConstants.merchantRequestsEndpoint,
      // NotificationMethodsConstants.notificationMethodEndpoint,
    ];
    return ExpansionTile(
      title: Text('mockups'.tr(context: context)),
      children: [
        SwitchListTile(
          title: const Text('Mock All APIs'),
          value: developerCubit.isAllEndpointsMocked,
          onChanged: (isMocked) => developerCubit.mockAllEndpointToMock(
            isMocked,
          ),
        ),
        ...endpoints
            .map(
              (endpoint) => SwitchListTile(
                title: Text(endpoint),
                value: developerCubit.isEndpointSelected(endpoint),
                onChanged: (isMocked) => developerCubit.markEndpointToMock(
                  endpoint,
                  isMocked,
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
