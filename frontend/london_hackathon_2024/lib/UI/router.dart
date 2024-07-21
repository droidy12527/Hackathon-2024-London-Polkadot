import 'package:flutter/material.dart';
import 'package:london_hackathon_2024/UI/views/authorisation/auth_handler.dart';
import 'package:london_hackathon_2024/UI/views/carfinder/carfinder_view.dart';
import 'package:london_hackathon_2024/UI/views/welcome_view.dart';

class MyRouter extends StatefulWidget {
  const MyRouter({
    super.key,
  });

  @override
  State<MyRouter> createState() => _MyRouterState();
}

const initialPage = 1;

class _MyRouterState extends State<MyRouter> {
  int _previousPage = -1;
  int _selectedIndex = initialPage; // Hard code !!!
  final PageController _pageController = PageController(initialPage: initialPage);
  bool _inPageSwitchAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (value) {
          if (_previousPage == -1) {
            Navigator.pop(context);
            return;
          }
          _onTappedTile(_previousPage);
          setState(() {
            _previousPage = -1;
          });
        },
        child: PageView(
          controller: _pageController,
          physics: _selectedIndex == 1 ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
          onPageChanged: (index) {
            if (_inPageSwitchAnimation == false) {
              setState(() {
                _previousPage = _selectedIndex;
                _selectedIndex = index;
              });
            }
          },
          children: [
            const CarFinderView(),
            WelcomeView(
              next: () {
                _onTappedTile(_selectedIndex + 1);
              },
              back: () {
                _onTappedTile(_selectedIndex - 1);
              },
            ),
            const AuthHandler(),
          ],
        ),
      ),
    );
  }

  void _onTappedTile(int index) async {
    if (_selectedIndex == index) {
      return;
    }

    _inPageSwitchAnimation = true;
    await _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: ((_selectedIndex - index).abs()) * 400),
      curve: Curves.ease,
    );
    setState(() {
      _previousPage = _selectedIndex;
      _selectedIndex = index;
    });
    _inPageSwitchAnimation = false;
  }
}
