import 'package:crypto_polygon/src/features/search_screen/data/bloc/search_bloc.dart';
import 'package:crypto_polygon/src/features/search_screen/ui/view_model/search_view_model.dart';
import 'package:crypto_polygon/src/features/search_screen/ui/widgets/cancel_button_widget.dart';
import 'package:crypto_polygon/src/features/search_screen/ui/widgets/one_tile.dart';
import 'package:crypto_polygon/src/features/search_screen/ui/widgets/search_field_widget.dart';
import 'package:crypto_polygon/src/widgets/divider_widget.dart';
import 'package:crypto_polygon/src/widgets/empty_case_widget.dart';
import 'package:crypto_polygon/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../widgets/app_error.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(),
      child: const _SearchScreenBody(),
    );
  }
}

class _SearchScreenBody extends StatelessWidget {
  const _SearchScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    return Scaffold(
      backgroundColor: AppColors.inactiveBackground,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor:
                  vm.isTyped() ? Colors.white : AppColors.inactiveBackground,
              pinned: false,
              snap: true,
              floating: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: SearchFieldWidget(vm: vm),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CancelButtonWidget(vm: vm),
                  ],
                ),
              ),
            )
          ];
        },
        body: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, SearchState state) {
          if (state is SearchLoadingState) {
            return const LoadingIndicator();
          }
          if (state is SearchLoadedState) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: state.results.results.isEmpty
                    ? const EmptyCaseWidget()
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return OneSearchTile(
                            companyName: state.results.results[index].name,
                            cryptoName: state.results.results[index].ticker,
                            query: vm.textController.text.toUpperCase(),
                          );
                        },
                        itemCount: state.results.results.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const DividerWidget();
                        },
                      ),
              ),
            );
          }
          if (state is SearchErrorState) {
            return AppErrorWidget(
              message: state.message,
              onTap: () => context.read<SearchBloc>().add(
                    SearchForCryptoEvent(query: vm.textController.text),
                  ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}

