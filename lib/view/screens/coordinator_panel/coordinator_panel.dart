import 'package:ctt/controllers/utils/my_color.dart';
import 'package:ctt/view/screens/coordinator_panel/task_screen.dart';
import 'package:ctt/view/screens/coordinator_panel/teachers_screen.dart';
import 'package:ctt/view/screens/coordinator_panel/teachers_verifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../custom_widgets/custom_button.dart';
import 'coordinator_screen.dart';
import 'dashboard_screen.dart';
class CoordinatorPanel extends StatefulWidget {
  const CoordinatorPanel({Key? key}) : super(key: key);

  @override

  _CoordinatorPanelState createState() => _CoordinatorPanelState();
}

class _CoordinatorPanelState extends State<CoordinatorPanel> {


  String selectedRoute = '/screen1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomSideBar(
            selectedRoute: selectedRoute,
            onSelected: (route) {
              setState(() {
                selectedRoute = route;
              });
            },
          ),
          Expanded(
              child: getBody()),
        ],
      ),
    );
  }

  Widget getBody() {
    switch (selectedRoute) {
      case '/screen1':
        return const DashboardScreen();
      case '/screen2':
        return const TeachersScreen();
      case '/screen3':
        return const TaskScreen();
      case '/screen4':
        return const TeachersVerificationsScreen();
      case '/screen5':
        return const CoordinatorScreen();
      case '/screen6':
        return const Center(child: Text('This is Screen 6'));
      default:
        return const Center(child: Text('ZEESHAN'));
    }
  }
}

class CustomSideBar extends StatelessWidget {
  final String selectedRoute;
  final ValueChanged<String> onSelected;

  const CustomSideBar({
    Key? key,
    required this.selectedRoute,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w, // Adjust as per your requirement
      decoration: BoxDecoration(color:  MyColor.blueColor,borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),bottomRight: Radius.circular(20))),
      child: Column(
        children: [
          getVertical(8.h),
          Image.asset("assets/png/inuLogo.png",width: 24.w,height: 16.h,),
          getVertical(7.h),
          CustomSidebarButton(
            title: 'Dashboard',
            route: '/screen1',
            isSelected: selectedRoute == '/screen1',
            onTap: () => onSelected('/screen1'),
          ),
          CustomSidebarButton(
            title: 'Teachers',
            route: '/screen2',
            isSelected: selectedRoute == '/screen2',
            onTap: () => onSelected('/screen2'),
          ),
          CustomSidebarButton(
            title: 'Tasks',
            route: '/screen3',
            isSelected: selectedRoute == '/screen3',
            onTap: () => onSelected('/screen3'),
          ),
          CustomSidebarButton(
            title: 'Verifications',
            route: '/screen4',
            isSelected: selectedRoute == '/screen4',
            onTap: () => onSelected('/screen4'),
          ),
          CustomSidebarButton(
            title: 'Coordinators',
            route: '/screen5',
            isSelected: selectedRoute == '/screen5',
            onTap: () => onSelected('/screen5'),
          ),
          getVertical(18.h),
          CustomSidebarButton(
            title: 'Delete Account',
            route: '/screen6',
            isSelected: selectedRoute == '/screen6',
            onTap: () => onSelected('/screen6'),
          ),
          getVertical(2.h),getHorizontal(2.h)
        ],
      ),
    );
  }
}

class CustomSidebarButton extends StatelessWidget {
  final String title;
  final String route;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomSidebarButton({
    Key? key,
    required this.title,
    required this.route,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.h),

        decoration: BoxDecoration(
          color: isSelected ? Colors.white : MyColor.darkBlueColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: isSelected ? MyColor.blueColor : Colors.white,
                    fontWeight: FontWeight.w600,fontSize: 13.px
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
