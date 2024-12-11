import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/app_route_const.dart';
import '../../../viewmodels/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_styles.dart';
import '../../../viewmodels/cargolift_detail_provider.dart';
import '../../../viewmodels/clock_provider.dart';
import '../../../widgets/custom_container_button.dart';
import 'sections/home_button_section_view.dart';
import 'sections/home_detail_information_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String liftStatus = '-';
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LiftCargoDetailProvider>().getDetailLift();
    });
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _appBar(context),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 17),
        child: Row(
          children: [
            // ----------------------------------------------
            // INFORMATION EMPLOYEE
            // ----------------------------------------------
            HomeDetailInformationView(flex: 3),
            Gap(14),
            // ----------------------------------------------
            // BUTTON LIFT CARGO
            // ----------------------------------------------
            HomeButtonSectionView(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer<ClockProvider>(builder: (context, clockProv, _) {
            return Text(
              clockProv.dateClockStr,
              style: AppStyles.label1SemiBold,
            );
          }),
          const Spacer(),
          CustomContainerButton(
            iconPath: SvgPicture.asset(AppIcons.icHistory),
            text: 'History',
            onTap: () {
              context.go(AppRouteConst.history);
            },
          ),
          const Gap(8),
          CustomContainerButton(
            iconPath: SvgPicture.asset(AppIcons.icLogOut, colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),),
            text: 'Log Out',
            onTap: () {
              context.read<AuthProvider>().logoutAndClearAuth();
              context.go(AppRouteConst.login);
            },
          ),
        ],
      ),
    );
  }
}

// OutlineInputBorder get _borderStyle => OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppRadius.r8),
//       borderSide: BorderSide(
//         color: AppColors.grey.shade400,
//         width: AppSizes.s1,
//       ),
//     );
