import 'package:assign01/page/bookmark_page.dart';
import 'package:assign01/page/profile_page.dart';
import 'package:assign01/page/trending_page.dart';
import 'package:assign01/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ScrollController _scrollListTrendingController = ScrollController();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        ;
      case 0:
        {
          if (_selectedIndex == index) {
            _scrollListTrendingController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          }
        }
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Github Trending App ',
              style: TextStyle(color: Colors.black),
            ),
            Image(
              image: AssetImage('assets/logo.png'),
              width: 30,
              height: 30,
            )
          ],
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          TrendingReposPage(
            scrollController: _scrollListTrendingController,
          ),
          BookmarkPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up,size: 24,),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark,size: 24,),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(backgroundImage:AssetImage('assets/logo.png'),radius: 12,),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: dartColor,
        unselectedFontSize: 0,
        onTap: _onItemTapped,
      ),
    );
  }
}
