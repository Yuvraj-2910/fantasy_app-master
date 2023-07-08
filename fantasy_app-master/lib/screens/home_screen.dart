import 'package:fantasyapp/screens/mymatches.dart';
import 'package:fantasyapp/screens/profile.dart';
import 'package:fantasyapp/screens/something.dart';
import 'package:fantasyapp/screens/wallet.dart';
import 'package:fantasyapp/widgets/category_container.dart';
import 'package:fantasyapp/widgets/contest_widget.dart';
import 'package:fantasyapp/widgets/wallet_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current_screen = 0;
  final List<Widget> screen = [
    Wallet(),
    ProfilePage(),
    Something(),
    MyMatches()
  ];
  Widget currentscreen = HomeScreen();
  final PageStorageBucket bucket = PageStorageBucket();

  List<String> categories = [
    'All',
    'Finance',
    'Gaming',
    'Technology',
    'Business',
    'Science',
    'Fitness',
    'Politics'
  ];

  int selectedIndex = 0;

  List<ConstestWidget> allContestWidgets = const [
    ConstestWidget(
      image: AssetImage('assets/images/gaming.webp'),
      prizepool: '10',
      entryfees: '220',
      category: 'Gaming',
    ),
    ConstestWidget(
      image: AssetImage('assets/images/finance.jpg'),
      prizepool: '50',
      entryfees: '100',
      category: 'Finance',
    ),
  ];

  List<ConstestWidget> get filteredContestWidgets {
    if (selectedIndex == 0) {
      return allContestWidgets;
    } else {
      String selectedCategory = categories[selectedIndex];
      return allContestWidgets
          .where((contest) => contest.category == selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: const Drawer(),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 176, 144, 229),
            title: const AppText(
              text: 'CONTESTS',
              fontWeight: FontWeight.bold,
            ),
            actions: [
              const WalletContainer(amount: 12),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Icon(
                    Icons.logout_rounded,
                    weight: 100,
                  ),
                ),
              ),
            ],
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.live_tv_rounded),
                text: 'Live',
              ),
              Tab(
                icon: Icon(Icons.calendar_month_outlined),
                text: 'Upcoming',
              ),
              Tab(
                icon: Icon(Icons.emoji_events_outlined),
                text: 'Results',
              ),
            ]),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: ((context, index) {
                    return CategoryContainer(
                      text: categories[index],
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      isSelected: selectedIndex == index,
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredContestWidgets.length,
                  itemBuilder: (context, index) {
                    return filteredContestWidgets[index];
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              shape: CircleBorder(),
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.account_balance_wallet_outlined),
              onPressed: () {}),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              width: 100,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MaterialButton(
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.home,
                                    color: current_screen == 0
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'home',
                                    style: TextStyle(
                                        color: current_screen == 0
                                            ? Colors.deepPurple
                                            : Colors.grey),
                                  )
                                ],
                              ),
                              minWidth: 30,
                              onPressed: () {
                                setState(() {
                                  currentscreen = HomeScreen();
                                  current_screen = 0;
                                });
                              }),
                          MaterialButton(
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.my_library_add,
                                    color: current_screen == 1
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'My Matches',
                                    style: TextStyle(
                                        color: current_screen == 1
                                            ? Colors.deepPurple
                                            : Colors.grey),
                                  )
                                ],
                              ),
                              minWidth: 30,
                              onPressed: () {
                                setState(() {
                                  currentscreen = MyMatches();
                                  current_screen = 1;
                                });
                              }),
                          MaterialButton(
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_upward,
                                    color: current_screen == 2
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'something',
                                    style: TextStyle(
                                        color: current_screen == 2
                                            ? Colors.deepPurple
                                            : Colors.grey),
                                  )
                                ],
                              ),
                              minWidth: 30,
                              onPressed: () {
                                setState(() {
                                  currentscreen = Something();
                                  current_screen = 2;
                                });
                              }),
                          MaterialButton(
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.person_3_rounded,
                                    color: current_screen == 3
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                  ),
                                  Text(
                                    'Profile',
                                    style: TextStyle(
                                        color: current_screen == 3
                                            ? Colors.deepPurple
                                            : Colors.grey),
                                  )
                                ],
                              ),
                              minWidth: 30,
                              onPressed: () {
                                setState(() {
                                  currentscreen = ProfilePage();
                                  current_screen = 3;
                                });
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
