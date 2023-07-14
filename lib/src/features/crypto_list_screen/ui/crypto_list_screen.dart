import 'package:crypto_polygon/constants/app_assets.dart';
import 'package:crypto_polygon/constants/app_styles.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/data/bloc/crypto_list_bloc.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/ui/view_model/crypto_list_view_model.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/ui/widgets/one_tile.dart';
import 'package:crypto_polygon/src/features/search_screen/ui/search_screen.dart';
import 'package:crypto_polygon/src/widgets/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  String upToDate = '';
  String dateBefore = '';
  @override
  void initState() {
    upToDate = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(
        const Duration(days: 2),
      ),
    );
    dateBefore = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(
        const Duration(days: 3),
      ),
    );
    context.read<CryptoListBloc>().add(
          GetCryptosEvent(
            upToDate: upToDate.toString(),
            dateBefore: dateBefore.toString(),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CryptoViewModel>(
        create: (context) => CryptoViewModel(),
        child: _CryptoListBody(
          upToDate: upToDate,
          dateBefore: dateBefore,
        ));
  }
}

class _CryptoListBody extends StatelessWidget {
  final String upToDate;
  final String dateBefore;
  const _CryptoListBody(
      {Key? key, required this.dateBefore, required this.upToDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CryptoViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              snap: true,
              floating: true,
              backgroundColor: Colors.white,
              title: const Text(
                'Криптовалюта',
                style: AppStyles.s26w400,
              ),
              elevation: 0,
              actions: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen())),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SvgPicture.asset(
                      AppAssets.svg.magnGlass,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.svg.ticker),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text(
                      'Тикер / Название',
                      style: AppStyles.s10w400,
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    GestureDetector(
                      onTap: () {
                        vm.filterList(true);
                      },
                      child: const Text(
                        'Цена',
                        style: AppStyles.s10w400,
                      ),
                    ),
                    SvgPicture.asset(AppAssets.svg.sort),
                    const SizedBox(
                      width: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        vm.filterList(false);
                      },
                      child: const Text(
                        'Изм. % / \$',
                        style: AppStyles.s10w400,
                      ),
                    ),
                    SvgPicture.asset(AppAssets.svg.sort),
                  ],
                ),
              ),
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CryptoListLoadedState) {
              return MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: vm.sortedList.isEmpty
                    ? const Center(child: Text('Пусто'))
                    : RefreshIndicator(
                        onRefresh: () async {
                          context.read<CryptoListBloc>().add(GetCryptosEvent(
                              dateBefore: dateBefore.toString(),
                              upToDate: upToDate.toString()));
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
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Divider(
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ),
                            itemCount: vm.sortedList.length),
                      ),
              );
            }
            if (state is CryptoListErrorState) {
              return AppErrorWidget(
                  message: state.message,
                  onTap: () => context.read<CryptoListBloc>().add(
                        GetCryptosEvent(
                          upToDate: upToDate.toString(),
                          dateBefore: dateBefore.toString(),
                        ),
                      ));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
