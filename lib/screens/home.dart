// import 'package:MetaBit/app_config.dart';
// import 'package:MetaBit/custom/box_decorations.dart';
// import 'package:MetaBit/helpers/shared_value_helper.dart';
// import 'package:MetaBit/helpers/shimmer_helper.dart';
// import 'package:MetaBit/my_theme.dart';
// import 'package:MetaBit/presenter/home_presenter.dart';
// import 'package:MetaBit/riaj/home_for_r.dart';
// import 'package:MetaBit/screens/filter.dart';
// import 'package:MetaBit/screens/flash_deal/flash_deal_list.dart';
// import 'package:MetaBit/screens/product/todays_deal_products.dart';
// import 'package:MetaBit/screens/top_sellers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../custom/feature_categories_widget.dart';
// import '../custom/featured_product_horizontal_list_widget.dart';
// import '../custom/home_all_products_2.dart';
// import '../custom/home_banner_one.dart';
// import '../custom/home_banner_two.dart';
// import '../custom/home_carousel_slider.dart';
// import '../custom/home_search_box.dart';
// import '../custom/pirated_widget.dart';

// class Home extends StatefulWidget {
//   Home({
//     Key? key,
//     this.title,
//     this.show_back_button = false,
//     go_back = true,
//   }) : super(key: key);

//   final String? title;
//   bool show_back_button;
//   late bool go_back;

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> with TickerProviderStateMixin {
//   HomePresenter homeData = HomePresenter();
//   final ScrollController _scrollController = ScrollController();
//   double _searchBoxOpacity = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     Future.delayed(Duration.zero).then((value) {
//       change();
//     });
//   }

//   void _onScroll() {
//     double offset = _scrollController.offset;

//     if (offset > 100 && _searchBoxOpacity > 0.0) {
//       setState(() {
//         _searchBoxOpacity = (_searchBoxOpacity - 0.05).clamp(0.0, 1.0);
//       });
//     } else if (offset <= 100 && _searchBoxOpacity < 1.0) {
//       setState(() {
//         _searchBoxOpacity = (_searchBoxOpacity + 0.5).clamp(0.0, 1.0);
//       });
//     }
//   }

//   void change() {
//     homeData.onRefresh();
//     homeData.mainScrollListener();
//     homeData.initPiratedAnimation(this);
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     homeData.pirated_logo_controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double statusBarHeight = MediaQuery.of(context).padding.top;

//     return WillPopScope(
//       onWillPop: () async {
//         return widget.go_back;
//       },
//       child: Directionality(
//         textDirection:
//             app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
//         child: SafeArea(
//           child: Scaffold(
//             //  appBar: buildAppBar(34, context),
//             backgroundColor: Colors.white,
//             body: ListenableBuilder(
//               listenable: homeData,
//               builder: (context, child) {
//                 return Stack(
//                   children: [
//                     RefreshIndicator(
//                       color: MyTheme.accent_color,
//                       backgroundColor: Colors.white,
//                       onRefresh: homeData.onRefresh,
//                       displacement: 0,
//                       child: CustomScrollView(
//                         controller: _scrollController,
//                         physics: const BouncingScrollPhysics(
//                           parent: AlwaysScrollableScrollPhysics(),
//                         ),
//                         slivers: <Widget>[
//                           SliverList(
//                             delegate: SliverChildListDelegate([
//                               AppConfig.purchase_code == ""
//                                   ? PiratedWidget(homeData: homeData)
//                                   : Container(),
//                               SizedBox(height: 2),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 child: HomeSearchBox(),
//                               ),
//                               SizedBox(height: 16),
//                               HomeCarouselSlider(
//                                 homeData: homeData,
//                                 context: context,
//                               ),
//                               SizedBox(height: 16),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     18.0, 0.0, 18.0, 0.0),
//                                 child: buildHomeMenu(context, homeData),
//                               ),
//                               SizedBox(height: 16),

//                               //Home slider one
//                               HomeBannerOne(
//                                 context: context,
//                                 homeData: homeData,
//                               ),
//                             ]),
//                           ),

//                           //Featured Categories
//                           SliverList(
//                             delegate: SliverChildListDelegate([
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(
//                                     20.0, 10.0, 18.0, 0.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [

//                                     Text(
//                                       AppLocalizations.of(context)!
//                                           .featured_categories_ucf,
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ]),
//                           ),

//                           SliverToBoxAdapter(
//                             child: SizedBox(
//                               height: 175,
//                               child: FeaturedCategoriesWidget(
//                                 homeData: homeData,
//                               ),
//                             ),
//                           ),
//                           SliverList(
//                             delegate: SliverChildListDelegate([
//                               Container(
//                                 height: 143,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                         image: AssetImage('assets/banner2.png'),
//                                         fit: BoxFit.cover)),
//                               )
//                             ]),
//                           ),

//                           //Featured Products
//                           SliverList(
//                             delegate: SliverChildListDelegate([
//                               Container(
//                                 height: 305,
//                                 color: Color(0xffF2F1F6),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           20, 22, 0, 0),
//                                       child: Text(
//                                         AppLocalizations.of(context)!
//                                             .featured_products_ucf,
//                                         style: TextStyle(
//                                           color: Color(0xff000000),
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           20, 15, 20, 0),
//                                       child:
//                                           FeaturedProductHorizontalListWidget(
//                                         homeData: homeData,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ]),
//                           ),
//                           //Home Banner Slider Two
//                           SliverList(
//                             delegate: SliverChildListDelegate([
//                               HomeBannerTwo(
//                                 context: context,
//                                 homeData: homeData,
//                               ),
//                             ]),
//                           ),
//                           SliverList(
//                             delegate: SliverChildListDelegate([
//                               Container(
//                                 color: Color(0xffF2F1F6),
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             18.0, 18.0, 20.0, 0.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               AppLocalizations.of(context)!
//                                                   .all_products_ucf,
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       //Home All Product
//                                       HomeAllProducts2(
//                                         context: context,
//                                         homeData: homeData,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 80,
//                               ),
//                             ]),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: buildProductLoadingContainer(homeData),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildHomeMenu(BuildContext context, HomePresenter homeData) {
//     // Check if the menu is loading (assuming both deals are false when data is not available)
//     if (!homeData.isFlashDeal && !homeData.isTodayDeal) {
//       return Container(
//         height: 40,
//         child: ShimmerHelper().buildHorizontalGridShimmerWithAxisCount(
//           crossAxisSpacing: 12.0,
//           mainAxisSpacing: 12.0,
//           item_count: 4, // Adjust as needed
//           mainAxisExtent: 40.0, // Height of each item
//         ),
//       );
//     }

//     final List<Map<String, dynamic>> menuItems = [
//       if (homeData.isTodayDeal)
//         {
//           "title": AppLocalizations.of(context)!.todays_deal_ucf,
//           "image": "assets/todays_deal.png",
//           "onTap": () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return TodaysDealProducts();
//             }));
//           },
//           "Textcolor": Colors.white,
//         },
//       if (homeData.isFlashDeal)
//         {
//           "title": AppLocalizations.of(context)!.flash_deal_ucf,
//           "image": "assets/flash_deal.png",
//           "onTap": () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return FlashDealList();
//             }));
//           },
//           "Textcolor": Colors.white,
//         },
//       {
//         "title": AppLocalizations.of(context)!.brands_ucf,
//         "image": "assets/brands.png",
//         "onTap": () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return Filter(selected_filter: "brands");
//           }));
//         },
//         "Textcolor": Color(0xff263140),
//       },
//       // Ensure `vendor_system.$` is valid or properly defined
//       if (vendor_system.$)
//         {
//           "title": AppLocalizations.of(context)!.top_sellers_ucf,
//           "image": "assets/top_sellers.png",
//           "onTap": () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return TopSellers();
//             }));
//           },
//           "Textcolor": Color(0xff263140),
//         },
//     ];

//     return Container(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: menuItems.length,
//         itemBuilder: (context, index) {
//           final item = menuItems[index];
//           Color containerColor;

//           if (index == 0) {
//             containerColor = Color(0xffE62D05);
//           } else if (index == 1) {
//             containerColor = Color(0xffF6941C);
//           } else {
//             containerColor = Color(0xffE9EAEB);
//           }

//           return GestureDetector(
//             onTap: item['onTap'],
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 7.0),
//               height: 40,
//               width: 106,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: containerColor,
//               ),
//               child: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Container(
//                         height: 16,
//                         width: 16,
//                         child: Image.asset(
//                           item['image'],
//                           color: item['Textcolor'],
//                         ),
//                       ),
//                     ),
//                     Text(
//                       item['title'],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: item['Textcolor'],
//                         fontWeight: FontWeight.w300,
//                         fontSize: 10,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   AppBar buildAppBar(double statusBarHeight, BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.white,
//       centerTitle: false,
//       elevation: 0,
//       flexibleSpace: Padding(
//         padding:
//             const EdgeInsets.only(top: 10.0, bottom: 10, left: 18, right: 18),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return Filter();
//             }));
//           },
//           child: HomeSearchBox(context: context),
//         ),
//       ),
//     );
//   }

// ignore_for_file: must_be_immutable, unused_local_variable

//   Container buildProductLoadingContainer(HomePresenter homeData) {
//     return Container(
//       height: homeData.showAllLoadingContainer ? 36 : 0,
//       width: double.infinity,
//       color: Colors.white,
//       child: Center(
//         child: Text(
//           homeData.totalAllProductData == homeData.allProductList.length
//               ? AppLocalizations.of(context)!.no_more_products_ucf
//               : AppLocalizations.of(context)!.loading_more_products_ucf,
//         ),
//       ),
//     );
//   }
// }
import 'package:MetaBit/app_config.dart';
import 'package:MetaBit/helpers/shared_value_helper.dart';
import 'package:MetaBit/helpers/shimmer_helper.dart';
import 'package:MetaBit/my_theme.dart';
import 'package:MetaBit/presenter/home_presenter.dart';
import 'package:MetaBit/screens/filter.dart';
import 'package:MetaBit/screens/wishlist/widgets/home_banner_four.dart';

import 'package:MetaBit/screens/flash_deal/flash_deal_list.dart';
import 'package:MetaBit/screens/product/todays_deal_products.dart';
import 'package:MetaBit/screens/top_sellers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../custom/feature_categories_widget.dart';
import '../custom/featured_product_horizontal_list_widget.dart';
import '../custom/home_all_products_2.dart';
import '../custom/home_banner_one.dart';
import '../custom/home_carousel_slider.dart';
import '../custom/home_search_box.dart';
import '../custom/pirated_widget.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
    this.title,
    this.show_back_button = false,
    go_back = true,
  }) : super(key: key);

  final String? title;
  bool show_back_button;
  late bool go_back;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  HomePresenter homeData = HomePresenter();
  final ScrollController _scrollController = ScrollController();
  double _searchBoxOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.delayed(Duration.zero).then((value) {
      change();
    });
  }

  void _onScroll() {
    double offset = _scrollController.offset;

    if (offset > 100 && _searchBoxOpacity > 0.0) {
      setState(() {
        _searchBoxOpacity = (_searchBoxOpacity - 0.05).clamp(0.0, 1.0);
      });
    } else if (offset <= 100 && _searchBoxOpacity < 1.0) {
      setState(() {
        _searchBoxOpacity = (_searchBoxOpacity + 0.5).clamp(0.0, 1.0);
      });
    }
  }

  void change() {
    homeData.onRefresh();
    homeData.mainScrollListener();
    homeData.initPiratedAnimation(this);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    homeData.pirated_logo_controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: () async {
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: ListenableBuilder(
              listenable: homeData,
              builder: (context, child) {
                return Stack(
                  children: [
                    RefreshIndicator(
                      color: MyTheme.accent_color,
                      backgroundColor: Colors.white,
                      onRefresh: homeData.onRefresh,
                      displacement: 0,
                      child:
                          //CustomScroll
                          CustomScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate([
                              AppConfig.purchase_code == ""
                                  ? PiratedWidget(homeData: homeData)
                                  : Container(),
                              SizedBox(height: 2),

                              // Padding(
                              //   padding: const EdgeInsets.fromLTRB(
                              //       12.0, 0.0, 0.0, 0.0),
                              //   child: buildHomeMenu(context, homeData),
                              // ),
                              SizedBox(height: 16),
                              //Header Banner
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      HomeCarouselSlider(
                                        homeData: homeData,
                                        context: context,
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 50,
                                    right: 50,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Filter()));
                                        },
                                        child: HomeSearchBox(context: context)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              //Home slider one
                              HomeBannerOne(
                                context: context,
                                homeData: homeData,
                              ),
                            ]),
                          ),

                          //Featured Categories
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 18.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .featured_categories_ucf,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),

                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 175,
                              child: FeaturedCategoriesWidget(
                                homeData: homeData,
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 0.0, 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flash Sale',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),

                          ///homeBannerfour
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 237,
                              child: HomeBannerFour(),
                            ),
                          ),

                          // SliverList(
                          //   delegate: SliverChildListDelegate([PhotoWidget()]),
                          // ),
                          //Featured Products
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Container(
                                height: 305,
                                color: Color(0xffF2F1F6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 22, 0, 0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .featured_products_ucf,
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 0),
                                      child:
                                          FeaturedProductHorizontalListWidget(
                                        homeData: homeData,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          //Home Banner Slider Two
                          // SliverList(
                          //   delegate: SliverChildListDelegate([
                          //     HomeBannerTwo(
                          //       context: context,
                          //       homeData: homeData,
                          //     ),
                          //   ]),
                          // ),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Container(
                                color: Color(0xffF2F1F6),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            18.0, 0.0, 20.0, 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .all_products_ucf,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Home All Product
                                      HomeAllProducts2(
                                        context: context,
                                        homeData: homeData,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 80,
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: buildProductLoadingContainer(homeData),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHomeMenu(BuildContext context, HomePresenter homeData) {
    // Check if the menu is loading (assuming both deals are false when data is not available)
    if (!homeData.isFlashDeal && !homeData.isTodayDeal) {
      return Container(
        height: 40,
        child: ShimmerHelper().buildHorizontalGridShimmerWithAxisCount(
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          item_count: 4, // Adjust as needed
          mainAxisExtent: 40.0, // Height of each item
        ),
      );
    }

    final List<Map<String, dynamic>> menuItems = [
      if (homeData.isTodayDeal)
        {
          "title": AppLocalizations.of(context)!.todays_deal_ucf,
          "image": "assets/todays_deal.png",
          "onTap": () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TodaysDealProducts();
            }));
          },
          "Textcolor": Colors.white,
        },
      if (homeData.isFlashDeal)
        {
          "title": AppLocalizations.of(context)!.flash_deal_ucf,
          "image": "assets/flash_deal.png",
          "onTap": () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FlashDealList();
            }));
          },
          "Textcolor": Colors.white,
        },
      {
        "title": AppLocalizations.of(context)!.brands_ucf,
        "image": "assets/brands.png",
        "onTap": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Filter(selected_filter: "brands");
          }));
        },
        "Textcolor": Color(0xff263140),
      },
      // Ensure `vendor_system.$` is valid or properly defined
      if (vendor_system.$)
        {
          "title": AppLocalizations.of(context)!.top_sellers_ucf,
          "image": "assets/top_sellers.png",
          "onTap": () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TopSellers();
            }));
          },
          "Textcolor": Color(0xff263140),
        },
    ];

    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          Color containerColor;

          if (index == 0) {
            containerColor = Color(0xffE62D05);
          } else if (index == 1) {
            containerColor = Color(0xffF6941C);
          } else {
            containerColor = Color(0xffE9EAEB);
          }

          return GestureDetector(
            onTap: item['onTap'],
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
              height: 40,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerColor,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 16,
                        width: 16,
                        child: Image.asset(
                          item['image'],
                          color: item['Textcolor'],
                        ),
                      ),
                    ),
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: item['Textcolor'],
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // AppBar buildAppBar(double statusBarHeight, BuildContext context) {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     // Don't show the leading button
  //     backgroundColor: Colors.white,
  //     centerTitle: false,
  //     elevation: 0,
  //     flexibleSpace: Padding(
  //       // padding:
  //       //     const EdgeInsets.only(top: 40.0, bottom: 22, left: 18, right: 18),
  //       padding:
  //           const EdgeInsets.only(top: 10.0, bottom: 10, left: 18, right: 18),
  //       child: GestureDetector(
  //         onTap: () {
  //           Navigator.push(context, MaterialPageRoute(builder: (context) {
  //             return Filter();
  //           }));
  //         },
  //         child: HomeSearchBox(context: context),
  //       ),
  //     ),
  //   );
  // }

  Container buildProductLoadingContainer(HomePresenter homeData) {
    return Container(
      height: homeData.showAllLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(
          homeData.totalAllProductData == homeData.allProductList.length
              ? AppLocalizations.of(context)!.no_more_products_ucf
              : AppLocalizations.of(context)!.loading_more_products_ucf,
        ),
      ),
    );
  }
}
