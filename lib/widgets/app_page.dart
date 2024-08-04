import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bases/base_state/base_cubit_state.dart';
import '../bases/base_view_cubit/base_cubit.dart';
import '../injection_container.dart';

abstract class AppScaffold<T extends Cubit> extends StatelessWidget {
  const AppScaffold({super.key});

  T get cubit => sl<T>();
  // TODO: implement this widgets
  Widget get loadingWidget => const CupertinoActivityIndicator();
  Widget errorWidget(String error) => const Text("error");
  Widget get noDataWidget => const Text("noData");

  Widget successBody<ExCubit extends ICubit<G>, G>(
    Widget Function(G data) builder,
  ) {
    return BlocBuilder<ExCubit, ICubitState<G>>(
      builder: (context, state) {
        return state.mapOrNull(
              success: (data) => builder(data.uiModel),
            ) ??
            const SizedBox();
      },
    );
  }
}


class SuccessBody<ExCubit extends ICubit<G>, G> extends StatelessWidget {
  final Widget Function(G data) builder;
  final ExCubit? cubit;
  const SuccessBody(
    this.builder, {
    super.key,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    if (cubit == null) {
      return BlocBuilder<ExCubit, ICubitState<G>>(
        builder: (context, state) {
          return state.mapOrNull(
                success: (data) => builder(data.uiModel),
              ) ??
              const SizedBox();
        },
      );
    }
    return BlocProvider<ExCubit>(
      create: (context) => cubit!,
      child: BlocBuilder<ExCubit, ICubitState<G>>(
        builder: (context, state) {
          return state.mapOrNull(
                success: (data) => builder(data.uiModel),
              ) ??
              const SizedBox();
        },
      ),
    );
  }
}
