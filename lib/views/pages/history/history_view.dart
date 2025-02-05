import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_route_const.dart';
import '../../../constants/app_styles.dart';
import '../../../models/lift_action_log.dart';
import '../../../services/locator.dart';
import '../../../services/shared_pref_services.dart';
import '../../../shared/extensions/context_extenstion.dart';
import '../../../shared/extensions/string_extenstion.dart';
import '../../../shared/finite_state.dart';
import '../../../shared/network/generic_failure_message_widget.dart';
import '../../../shared/network/generic_loading_widget.dart';
import '../../../shared/utils/date_formating.dart';
import '../../../viewmodels/cargolift_logs_provider.dart';
import '../../../widgets/custom_chached_image.dart';
import '../../../widgets/datepicker_custom.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final _sharedPref = serviceLocator<SharedPreferencesServices>();

  bool loginStatus = false;

  @override
  void initState() {
    if (_sharedPref.readToken.isNotEmpty) {
      loginStatus = true;
    } else {
      loginStatus = false;
    }
    var provLogs = context.read<CargoLiftLogsProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provLogs.dateTimeShowing = DateTime.now();
      provLogs.getLogActions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            _datePicker(context),
            // ----------------------------------------------
            // Header
            // ----------------------------------------------
            _headerTable(context),
            // ----------------------------------------------
            // data table
            // ----------------------------------------------
            _dataTable(context),
          ],
        ),
      ),
    );
  }

  Widget _datePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end ,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<CargoLiftLogsProvider>(builder: (context, provDetail, _) {
            return Text(
              formatDateString(
                provDetail.dateTimeShowing.toString(),
                toFormat: "dd MMMM yyyy",
              ),
              style: AppStyles.label2SemiBold,
            );
          }),
          const Gap(8),
          GestureDetector(
            onTap: () {
              var logProvider = context.read<CargoLiftLogsProvider>();
              var currentDate = logProvider.dateTimeShowing;

              showCustomDatePickerNormal(
                context,
                currentDate: currentDate,
                firstDate: DateTime(2024),
                lastDate: DateTime.now(), 
              ).then((selectedDate) {
                if (selectedDate != currentDate) {
                  logProvider.updateDateShowing(selectedDate);
                }
              });
            },
            child: SvgPicture.asset(AppIcons.icCalender),
          ),
          
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      forceMaterialTransparency: true,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 80,
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        onPressed: () {
          loginStatus
              ? context.go(AppRouteConst.home)
              : context.go(AppRouteConst.login);
        },
        icon: const Icon(Icons.arrow_back_ios_outlined, size: 24, weight: 500),
      ),
      title: const Text(
        'History Status Lift Cargo Control',
        style: AppStyles.label1Medium,
      ),
    );
  }
}

Widget _headerTable(BuildContext context) {
  return Table(
    border: const TableBorder(
      horizontalInside: BorderSide.none,
      verticalInside: BorderSide.none,
      bottom: BorderSide.none,
    ),
    columnWidths: {
      0: FixedColumnWidth(context.fullWidth * 0.04),
      1: FixedColumnWidth(context.fullWidth * 0.53),
      2: FixedColumnWidth(context.fullWidth * 0.1),
      3: FixedColumnWidth(context.fullWidth * 0.12),
    },
    children: [
      // ----------------------------------------------
      // HEADER TABEL
      // ----------------------------------------------
      TableRow(
        decoration:
            BoxDecoration(color: Colors.grey.shade300.withOpacity(0.25)),
        children: [
          _buildTableHeaderCell('No'),
          _buildTableHeaderCell('Employee Name'),
          _buildTableHeaderCell('Status'),
          _buildTableHeaderCell('Location'),
          _buildTableHeaderCell('Date'),
        ],
      ),
    ],
  );
}


Widget _dataTable(BuildContext context) {
  return Consumer<CargoLiftLogsProvider>(
    builder: (context, logProvider, _) {
      var state = logProvider.state;

      if (state.isLoading || state.isInitial) {
        return const Center(heightFactor: 5, child: GenericCircleLoading());
      } else if (state.isFailed) {
        return Center(
          heightFactor: 3,
          child: GenericFailureMessage(
            onTap: () {
              logProvider.getLogActions();
            },
            title: logProvider.failure?.codeMsg,
            subText: logProvider.failure?.message,
          ),
        );
      } else if (state.isLoaded) {
        List<LiftActionLog> historyLogs = logProvider.historyLogs;

        if (historyLogs.isEmpty) {
          return const Center(heightFactor: 6, child: Text("No Data History"));
        }

        return Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Table(
                border: const TableBorder(
                  horizontalInside: BorderSide.none,
                  verticalInside: BorderSide.none,
                  bottom: BorderSide.none,
                ),
                columnWidths: {
                  0: FixedColumnWidth(context.fullWidth * 0.04),
                  1: FixedColumnWidth(context.fullWidth * 0.53),
                  2: FixedColumnWidth(context.fullWidth * 0.1),
                  3: FixedColumnWidth(context.fullWidth * 0.12),
                },
                children: [
                  // ----------------------------------------------
                  // DATA TABEL
                  // ----------------------------------------------
            
                  for (var i = 0; i < historyLogs.length; i++)
                    tableRowData(no: "${i + 1}", data: historyLogs.elementAt(i))
            
                  // tableRowData(),
                ],
              ),
            ),
          ),
        );
      }

      return const SizedBox.shrink();
    },
  );
}

TableRow tableRowData({required String no, required LiftActionLog data}) {
  return TableRow(
    decoration: _underLine,
    children: [
      _buildTableCell(no),
      _buildTableCellWithAvatar(
        text:
            '${(data.employeeName ?? "-").toTitleCase()} (${data.employeeBadge})',
        imgpath: data.userImage ?? "",
      ),
      _buildTableCell(data.cargoLiftButton ?? ""), //'F1 to F3'
      _buildTableCell(
          "${data.floorName ?? ""} - ${data.departmentName ?? ""}"), //    'LT.1 SMT'
      _buildTableCell(formatDateString(data.createdAt ?? "-",
          toFormat: "dd MMM yyyy, HH:mm")), // '26 Nov 2024, 11:10'
    ],
  );
}

Widget _buildTableHeaderCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: Text(
      text,
      style: AppStyles.body2Medium,
    ),
  );
}

Widget _buildTableCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: Text(
      text,
      style: AppStyles.body2Regular,
    ),
  );
}

Widget _buildTableCellWithAvatar({
  required String text,
  required String imgpath,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            shadows: [BoxShadow(spreadRadius: 1, color: AppColors.grey)],
          ),
          child: CustomCachedImage(
            url: imgpath,
            boxFit: BoxFit.cover,
            errorWidget: Icon(
              Icons.person,
              size: 16,
              color: AppColors.black.shade200,
            ),
          ),
        ),
        const Gap(8),
        Text(
          text,
          style: AppStyles.body2Regular,
        ),
      ],
    ),
  );
}

BoxDecoration get _underLine => BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey.shade500.withOpacity(0.5),
        ),
      ),
    );
