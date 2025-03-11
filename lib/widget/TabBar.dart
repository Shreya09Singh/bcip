// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarScreen extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final int initialIndex;

  const TabBarScreen({
    Key? key,
    required this.tabs,
    required this.tabViews,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: widget.tabs.length,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        backgroundColor: backgroundBlackColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: screenHeight * 0.16, // 16% of screen height
          backgroundColor: backgroundBlackColor,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                Text(
                  'Progress',
                  style: GoogleFonts.poppins(
                    color: brandPrimaryColor,
                    fontSize: screenWidth * 0.08, // 8% of screen width
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                Center(
                  child: Container(
                    height: screenHeight * 0.06, // 6% of screen height
                    width: screenWidth * 0.9, // 90% of screen width
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.01), // 1% padding
                    child: TabBar(
                      dividerHeight: 0,
                      controller: _tabController,
                      tabs: widget.tabs,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      labelColor: brandPrimaryColor,
                      unselectedLabelColor: Colors.white,
                      labelStyle: TextStyle(
                          fontSize: screenWidth * 0.04), // 4% of width
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: widget.tabViews,
        ),
      ),
    );
  }
}
