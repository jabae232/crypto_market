import 'package:crypto_polygon/constants/app_assets.dart';
import 'package:crypto_polygon/constants/app_styles.dart';
import 'package:crypto_polygon/src/features/search_screen/data/bloc/search_bloc.dart';
import 'package:crypto_polygon/src/features/search_screen/ui/view_model/search_view_model.dart';
import 'package:crypto_polygon/src/features/search_screen/ui/widgets/one_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (context) => SearchViewModel(),
      child: const _SearchScreenBody(),
    );
  }
}

class _SearchScreenBody extends StatefulWidget {
  const _SearchScreenBody({Key? key}) : super(key: key);

  @override
  State<_SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<_SearchScreenBody> {
  late TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    return Scaffold(
      backgroundColor: AppColors.inactiveBackground,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
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
                        child: TextField(
                          controller: textController,
                          onChanged: (value) {
                            vm.controller = value;
                            context.read<SearchBloc>().add(
                                  SearchForCryptoEvent(query: value),
                                );
                          },
                          decoration: InputDecoration(
                            suffixIcon: vm.isTyped()
                                ? IconButton(
                                    onPressed: () {
                                      textController.clear();
                                      vm.controller = '';
                                      context.read<SearchBloc>().add(
                                            SearchForCryptoEvent(query: ''),
                                          );
                                    },
                                    icon: SvgPicture.asset(
                                      AppAssets.svg.fieldClear,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'Тикер / Название',
                            hintStyle: AppStyles.s16w400,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                AppAssets.svg.search,
                                width: 18,
                                height: 18,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0.50,
                                color: AppColors.defaultGrey,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0.50,
                                color: AppColors.defaultGrey,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Отмена',
                        style: AppStyles.s16w600.copyWith(
                            color: vm.isTyped()
                                ? AppColors.defaultGreen
                                : AppColors.textBlack),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {
          if (state is SearchLoadedState) {}
        }, builder: (context, SearchState state) {
          if (state is SearchLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchLoadedState) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: state.results.results.isEmpty
                    ? const Center(
                        child: Text('Пусто'),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return OneSearchTile(
                            companyName: state.results.results[index].name,
                            cryptoName: state.results.results[index].ticker,
                            query: textController.text.toUpperCase(),
                          );
                        },
                        itemCount: state.results.results.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(
                              thickness: 1,
                              height: 1,
                            ),
                          );
                        },
                      ),
              ),
            );
          }
          if (state is SearchErrorState) {}
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
