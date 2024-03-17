import 'package:final_pro/Client/proposal/show_active_proposal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:final_pro/Client/categories/apparel/components/display_store.dart';
import 'package:final_pro/Client/order/order_show_screen.dart';
import 'package:final_pro/Client/proposal/create_proposal.dart';
import 'package:final_pro/Client/proposal/show_archive_proposal.dart';
import 'package:final_pro/Client/proposal/show_proposal.dart';

import '../fitness_app_theme.dart';
import '../ui_view/area_list_view.dart';
import '../ui_view/running_view.dart';
import '../ui_view/title_view.dart';
import '../ui_view/workout_view.dart';

class ProposalScreen extends StatefulWidget {
  const ProposalScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _ProposalScreenState createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  late final TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 3, vsync: this);
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  const SliverAppBar(
                    title: Text('Proposal'),
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(child: Text('Create Proposal')),
                        Tab(child: Text('Active')),
                        Tab(child: Text('Archived')),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  const CreateProposalScreen(),
                  const ActiveProposalShowScreen(),
                  const ArchivedProposalShowScreen(),
                ],
              ),
            ),
          )),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return Text("HELLO");
        }
      },
    );
  }
}
