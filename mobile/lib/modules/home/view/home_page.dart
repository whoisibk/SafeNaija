import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/di/di.dart';
import 'package:mobile/common/services/overlay_service.dart';
import 'package:mobile/common/widgets/toast_widget.dart';
import 'package:mobile/modules/auth/cubit/auth_cubit.dart';
import 'package:mobile/modules/home/widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Home Content'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              getIt<OverlayService>().show(
                ToastType.success,
                'Success!',
                message: 'This is a success message.',
              );
            },
            child: const Text('Show Success Toast'),
          ),
          ElevatedButton(
            onPressed: () {
              getIt<OverlayService>().show(
                ToastType.warning,
                'Warning!',
                message: 'This is a warning message.',
              );
            },
            child: const Text('Show Warning Toast'),
          ),
          ElevatedButton(
            onPressed: () {
              getIt<OverlayService>().show(
                ToastType.error,
                'Error!',
                message: 'This is an error message.',
              );
            },
            child: const Text('Show Error Toast'),
          ),
          ElevatedButton(
            onPressed: () {
              getIt<OverlayService>().show(
                ToastType.info,
                'Info!',
                message: 'This is an info message.',
              );
            },
            child: const Text('Show Info Toast'),
          ),
        ],
      ),
    ),
    Center(child: Text('History Content')),
    Center(child: Text('Create/Add Content')), // Placeholder for "+" action
    Center(child: Text('Alerts Content')),
    Center(child: Text('Profile Content')),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Handle the "Add" action (FAB) here
      getIt<OverlayService>().show(
        ToastType.info,
        'Add Action',
        message: 'This will open the create/add modal.',
      );
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeNaija'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthCubit>().logout();
              // Router redirect should handle navigation to Login
            },
          ),
        ],
      ),
      extendBody: true,
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
