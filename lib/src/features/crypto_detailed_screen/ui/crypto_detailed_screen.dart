import 'package:crypto_polygon/constants/app_styles.dart';
import 'package:crypto_polygon/src/features/crypto_detailed_screen/ui/view_model/crypto_detailed_view_model.dart';
import 'package:crypto_polygon/src/features/crypto_detailed_screen/ui/widgets/helper_high_closed.dart';
import 'package:crypto_polygon/src/features/crypto_detailed_screen/ui/widgets/text_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../../search_screen/data/dto/crypto_data.dart';
import '../data/bloc/crypto_detailed_bloc.dart';

class CryptoDetailedScreen extends StatefulWidget {
  final String ticker;
  final String tickerFormatted;
  final String priceToDay;
  const CryptoDetailedScreen(
      {Key? key,
      required this.ticker,
      required this.priceToDay,
      required this.tickerFormatted})
      : super(key: key);

  @override
  State<CryptoDetailedScreen> createState() => _CryptoDetailedScreenState();
}

class _CryptoDetailedScreenState extends State<CryptoDetailedScreen> {
  @override
  void initState() {
    final dateFrom = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(
        const Duration(days: 7),
      ),
    );
    final dateTo = DateFormat('yyyy-MM-dd').format(DateTime.now());
    context.read<CryptoDetailedBloc>().add(
          GetDetailsEvent(
              dateFrom: dateFrom.toString(),
              dateTo: dateTo.toString(),
              timespan: 'day',
              ticker: widget.ticker),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CryptoDetailedViewModel>(
      create: (context) => CryptoDetailedViewModel(),
      child: _CryptoDetailedScreenBody(
        ticker: widget.ticker,
        tickerFormatted: widget.tickerFormatted,
        priceToDay: widget.priceToDay,
      ),
    );
  }
}

class _CryptoDetailedScreenBody extends StatelessWidget {
  final String ticker;
  final String tickerFormatted;
  final String priceToDay;
  const _CryptoDetailedScreenBody(
      {Key? key,
      required this.ticker,
      required this.tickerFormatted,
      required this.priceToDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CryptoDetailedViewModel>();
    return Scaffold(
      backgroundColor: AppColors.detailedBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(AppAssets.svg.arrowBack),
            )),
        title: Text(
          tickerFormatted,
          style: AppStyles.s26w400,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  const Text(
                    'ЦЕНА: ',
                    style: AppStyles.s14w400,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    priceToDay,
                    style:
                        AppStyles.s26w400.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButtons(
                      func: () {
                        final upToDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        final dateBefore = DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(
                            const Duration(days: 1),
                          ),
                        );
                        vm.currentSortType = SortTypes.sortDay;
                        context.read<CryptoDetailedBloc>().add(
                              GetDetailsEvent(
                                  dateFrom: dateBefore.toString(),
                                  dateTo: upToDate.toString(),
                                  timespan: 'hour',
                                  ticker: ticker),
                            );
                      },
                      date: '1Д',
                      isSelected: vm.currentSortType == SortTypes.sortDay,
                    ),
                    TextButtons(
                      func: () {
                        vm.currentSortType = SortTypes.sort5Days;
                        final upToDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        final dateBefore = DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(
                            const Duration(days: 5),
                          ),
                        );
                        context.read<CryptoDetailedBloc>().add(
                              GetDetailsEvent(
                                  dateFrom: dateBefore.toString(),
                                  dateTo: upToDate.toString(),
                                  timespan: 'day',
                                  ticker: ticker),
                            );
                      },
                      date: '5Д',
                      isSelected: vm.currentSortType == SortTypes.sort5Days,
                    ),
                    TextButtons(
                      func: () {
                        vm.currentSortType = SortTypes.sortWeek;
                        final upToDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        final dateBefore = DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(
                            const Duration(days: 7),
                          ),
                        );
                        context.read<CryptoDetailedBloc>().add(
                              GetDetailsEvent(
                                  dateFrom: dateBefore.toString(),
                                  dateTo: upToDate.toString(),
                                  timespan: 'day',
                                  ticker: ticker),
                            );
                      },
                      date: '1Н',
                      isSelected: vm.currentSortType == SortTypes.sortWeek,
                    ),
                    TextButtons(
                      func: () {
                        vm.currentSortType = SortTypes.sortMonth;
                        final upToDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        final dateBefore = DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(
                            const Duration(days: 30),
                          ),
                        );
                        context.read<CryptoDetailedBloc>().add(
                              GetDetailsEvent(
                                  dateFrom: dateBefore.toString(),
                                  dateTo: upToDate.toString(),
                                  timespan: 'day',
                                  ticker: ticker),
                            );
                      },
                      date: '1МЕС',
                      isSelected: vm.currentSortType == SortTypes.sortMonth,
                    ),
                    TextButtons(
                      func: () {
                        vm.currentSortType = SortTypes.sort3Month;
                        final upToDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        final dateBefore = DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(
                            const Duration(days: 90),
                          ),
                        );
                        context.read<CryptoDetailedBloc>().add(
                              GetDetailsEvent(
                                  dateFrom: dateBefore.toString(),
                                  dateTo: upToDate.toString(),
                                  timespan: 'week',
                                  ticker: ticker),
                            );
                      },
                      date: '3МЕС',
                      isSelected: vm.currentSortType == SortTypes.sort3Month,
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<CryptoDetailedBloc, CryptoDetailedState>(
            listener: (context, state) {
              if (state is CryptoDetailedLoadedState) {
              }
            },
            builder: (context, state) {
              if (state is CryptoDetailedLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CryptoDetailedLoadedState) {
                final listData = state.cryptos.results
                    .map((e) => CryptoData(e.t, e.o, e.c, e.h, e.l))
                    .toList();
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SfCartesianChart(
                            plotAreaBorderWidth: 0.0,
                            primaryXAxis: DateTimeAxis(),
                            series: <ChartSeries>[
                              LineSeries<CryptoData, DateTime>(
                                dataLabelSettings: const DataLabelSettings(
                                    textStyle: AppStyles.s10w400),
                                color: AppColors.chartGreen,
                                animationDuration: 1250,
                                dataSource: listData,
                                xValueMapper: (CryptoData data, _) => data.time,
                                yValueMapper: (CryptoData data, _) =>
                                    data.close,
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: HighLowOpenClosed(
                                  title: "HIGH:",
                                  value: "${state.cryptos.results.last.h}",
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: HighLowOpenClosed(
                                  title: "OPEN:",
                                  value: "${state.cryptos.results.last.o}",
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: HighLowOpenClosed(
                                  title: "LOW:",
                                  value: "${state.cryptos.results.last.l}",
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: HighLowOpenClosed(
                                  title: "CLOSE:",
                                  value: "${state.cryptos.results.last.c}",
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              if (state is CryptoDetailedErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}



