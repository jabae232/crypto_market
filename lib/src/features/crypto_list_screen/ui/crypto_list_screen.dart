import 'package:crypto_polygon/constants/app_constants.dart';
import 'package:crypto_polygon/constants/app_styles.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/data/bloc/crypto_list_bloc.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/ui/view_model/crypto_list_view_model.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/ui/widgets/header_list_widget.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/ui/widgets/one_tile.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/ui/widgets/search_btn_widget.dart';
import 'package:crypto_polygon/src/widgets/app_error.dart';
import 'package:crypto_polygon/src/widgets/divider_widget.dart';
import 'package:crypto_polygon/src/widgets/empty_case_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../widgets/loading_indicator.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CryptoViewModel>(
      create: (context) => CryptoViewModel(),
      child: const _CryptoListBody(),
    );
  }
}

class _CryptoListBody extends StatelessWidget {
  const _CryptoListBody({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CryptoViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              centerTitle: false,
              pinned: false,
              snap: true,
              floating: true,
              backgroundColor: Colors.white,
              title: Text(
                'Криптовалюта',
                style: AppStyles.s26w400,
              ),
              elevation: 0,
              actions: [
                SearchButtonWidget(),
              ],
            ),
            SliverToBoxAdapter(
              child: HeaderListWidget(vm: vm),
            ),
          ];
        },
        body: BlocConsumer<CryptoListBloc, CryptoListState>(
          listener: (context, state) {
            if (state is CryptoListLoadedState) {
              vm.cryptosDateBefore = state.cryptosDateBefore;
              vm.cryptosUpToDate = state.cryptosUpToDate;
              vm.listMatch();
            }
          },
          builder: (context, CryptoListState state) {
            if (state is CryptoListLoadingState) {
              return const LoadingIndicator();
            }
            if (state is CryptoListLoadedState) {
              return MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: vm.sortedList.isEmpty
                    ? const EmptyCaseWidget()
                    : RefreshIndicator(
                        onRefresh: () async {
                          context.read<CryptoListBloc>().add(
                                GetCryptosEvent(
                                  dateBefore:
                                      AppConstants.dateBefore.toString(),
                                  upToDate: AppConstants.upToDate.toString(),
                                ),
                              );
                        },
                        child: ListView.separated(
                            itemBuilder: (context, int index) {
                              return OneTile(
                                name: vm.sortedList[index].t,
                                priceToDay: vm.sortedList[index].c,
                                priceBefore:
                                    vm.sortedList[index].prevPrice ?? 0,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const DividerWidget(),
                            itemCount: vm.sortedList.length),
                      ),
              );
            }
            if (state is CryptoListErrorState) {
              return AppErrorWidget(
                message: state.message,
                onTap: () => context.read<CryptoListBloc>().add(
                      GetCryptosEvent(
                        upToDate: AppConstants.upToDate.toString(),
                        dateBefore: AppConstants.dateBefore.toString(),
                      ),
                    ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
