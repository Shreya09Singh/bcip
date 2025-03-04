import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bciapplication/utils/constants.dart';

class TabBarScreen extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews;

  const TabBarScreen({
    Key? key,
    required this.tabs,
    required this.tabViews,
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
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlackColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 130,
        backgroundColor: backgroundBlackColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Text(
                'Progress',
                style: GoogleFonts.poppins(
                  color: brandPrimaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF334155),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(4),
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
    );
  }
}
