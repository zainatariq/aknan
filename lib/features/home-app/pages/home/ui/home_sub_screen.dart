import 'package:aknan_user_app/features/home-app/main-bg-page/cubit/main_bg_cubit.dart';

import '../../../../../bases/base_state/base_cubit_state.dart';
import '../../../../../bases/base_view_cubit/base_cubit.dart';
import '../../../../../widgets/custom_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../bases/base-models/elevator_model.dart';
import '../../../../../bases/base-models/maintenance_request_model.dart';
import '../../../../../global/app-assets/assets.dart';
import '../../../../../localization/change_language.dart';
import '../../../../../localization/locale_keys.g.dart';
import '../../../../../widgets/app_notification_widget.dart';
import '../../../../../widgets/app_page.dart';
import '../cubit/cubit/home_sub_screen_cubit.dart';
import '../models/banners.dart';
import 'widget/elevator_view_item.dart';
import 'widget/maintenance_request_item_view.dart';

class HomeSubScreen extends AppScaffold<HomeNetSubScreenCubit> {
  const HomeSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _handelReloadOnChangeLangCase(context);
    return SuccessBody<HomeNetSubScreenCubit, HomeRes>((data) {
      return Builder(builder: (context) {
        return RefreshIndicator(
          onRefresh: () =>
              BlocProvider.of<HomeNetSubScreenCubit>(context).getHome(),
          child: Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Assets.imagesPngsLogo,
                  height: 50,
                  width: 50,
                ),
              ),
              actions: [
                AppNotificationWidget(
                  nums: int.parse(data.data?.notificationCount ?? "0"),
                )
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              // padding:
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: BanarView(
                      list: data.data?.sliders ?? [],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.maintenance_requests.tre,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: MaintenanceRequestsView(
                      items: [
                        ...data.data?.reqs ?? [],
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.types_of_elevators.tre,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TypeOfElevatorView(
                      resList: data.data?.elevatorTypes ?? [],
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: SvgPicture.asset(Assets.imagesSvgsIcoFabH),
              onPressed: () {},
            ),
          ),
        );
      });
    });
  }

  void _handelReloadOnChangeLangCase(BuildContext context) {
    if (MainBgCubit.get(context).reloadHome) {
      BlocProvider.of<HomeNetSubScreenCubit>(context).getHome();
      MainBgCubit.get(context).reloadHome = false;
    }
  }
}

class BanarView extends StatefulWidget {
  final List<Banners> list;
  const BanarView({
    super.key,
    required this.list,
  });

  @override
  State<BanarView> createState() => _BanarViewState();
}

class _BanarViewState extends State<BanarView> {
  int currentIndex = 0;

  int get totalBanarCount => widget.list.length;

  _onPageChanged(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (totalBanarCount > 0)
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  disableCenter: true,
                  autoPlayInterval: const Duration(seconds: 7),
                  onPageChanged: (index, reason) {
                    _onPageChanged(index);
                  },
                ),
                itemCount: totalBanarCount,
                itemBuilder: (context, index, _) {
                  var item = widget.list[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CustomImage(
                      image: item.img,
                      radius: 15,
                    ),
                  );
                },
              )),
        if (totalBanarCount > 0)
          Center(
            child: DotsIndicator(
              dotsCount: totalBanarCount,
              position: currentIndex,
              decorator: DotsDecorator(
                color: Theme.of(context).shadowColor,
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}

class MaintenanceRequestsView extends AppScaffold<HomeSubScreenCubit> {
  final List<MaintenanceRequestModel> items;
  const MaintenanceRequestsView({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      width: MediaQuery.sizeOf(context).width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 15);
        },
        itemBuilder: (BuildContext context, int index) {
          return MaintenanceRequestItemView(
            item: items[index],
          );
        },
      ),
    );
  }
}

class TypeOfElevatorView extends StatelessWidget {
  const TypeOfElevatorView({super.key, required this.resList});
  final List<ElevatorModel> resList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: resList.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: (BuildContext context, int index) {
        return ElevatorViewItem(
          item: resList[index],
        );
      },
    );
  }
}
