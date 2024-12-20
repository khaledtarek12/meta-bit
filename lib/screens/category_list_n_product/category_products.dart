// import 'package:MetaBit/custom/box_decorations.dart';
// import 'package:MetaBit/custom/device_info.dart';
// import 'package:MetaBit/custom/useful_elements.dart';
// import 'package:MetaBit/data_model/category_response.dart';
// import 'package:MetaBit/helpers/shimmer_helper.dart';
// import 'package:MetaBit/my_theme.dart';
// import 'package:MetaBit/repositories/category_repository.dart';
// import 'package:MetaBit/repositories/product_repository.dart';
// import 'package:MetaBit/ui_elements/product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class CategoryProducts extends StatefulWidget {
//   CategoryProducts({Key? key, required this.slug}) : super(key: key);
//   final String slug;

//   @override
//   _CategoryProductsState createState() => _CategoryProductsState();
// }

// class _CategoryProductsState extends State<CategoryProducts> {
//   ScrollController _scrollController = ScrollController();
//   ScrollController _xcrollController = ScrollController();
//   TextEditingController _searchController = TextEditingController();

//   int _page = 1;
//   int? _totalData = 0;
//   bool _isInitial = true;
//   String _searchKey = "";
//   Category? categoryInfo;
//   bool _showSearchBar = false;
//   List<dynamic> _productList = [];
//   bool _showLoadingContainer = false;
//   List<Category> _subCategoryList = [];

//   getSubCategory() async {
//     var res = await CategoryRepository().getCategories(parent_id: widget.slug);
//     _subCategoryList.addAll(res.categories!);
//     setState(() {});
//   }

//   getCategoryInfo() async {
//     var res = await CategoryRepository().getCategoryInfo(widget.slug);
//     print(res.categories.toString());
//     if (res.categories?.isNotEmpty ?? false) {
//       categoryInfo = res.categories?.first ?? null;
//     }
//     setState(() {});
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCategoryInfo();
//     fetchAllDate();

//     _xcrollController.addListener(() {
//       if (_xcrollController.position.pixels ==
//           _xcrollController.position.maxScrollExtent) {
//         setState(() {
//           _page++;
//         });
//         _showLoadingContainer = true;
//         fetchData();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _scrollController.dispose();
//     _xcrollController.dispose();
//     super.dispose();
//   }

//   fetchData() async {
//     var productResponse = await ProductRepository()
//         .getCategoryProducts(id: widget.slug, page: _page, name: _searchKey);
//     _productList.addAll(productResponse.products!);
//     _isInitial = false;
//     _totalData = productResponse.meta!.total;
//     _showLoadingContainer = false;
//     setState(() {});
//   }

//   fetchAllDate() {
//     fetchData();
//     getSubCategory();
//   }

//   reset() {
//     _subCategoryList.clear();
//     _productList.clear();
//     _isInitial = true;
//     _totalData = 0;
//     _page = 1;
//     _showLoadingContainer = false;
//     setState(() {});
//   }

//   Future<void> _onRefresh() async {
//     reset();
//     fetchAllDate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffECF1F5),
//       appBar: buildAppBar(context),
//       body: Stack(
//         children: [
//           buildProductList(),
//           Align(
//               alignment: Alignment.bottomCenter, child: buildLoadingContainer())
//         ],
//       ),
//     );
//   }

//   Container buildLoadingContainer() {
//     return Container(
//       height: _showLoadingContainer ? 36 : 0,
//       width: double.infinity,
//       color: Colors.white,
//       child: Center(
//         child: Text(_totalData == _productList.length
//             ? AppLocalizations.of(context)!.no_more_products_ucf
//             : AppLocalizations.of(context)!.loading_more_products_ucf),
//       ),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       toolbarHeight: _subCategoryList.isEmpty
//           ? DeviceInfo(context).height! / 10
//           : DeviceInfo(context).height! / 6.5,
//       flexibleSpace: Container(
//         height: DeviceInfo(context).height! / 4,
//         width: DeviceInfo(context).width,
//         color: Color(0xffECF1F5),
//         alignment: Alignment.topRight,
//         // child: Image.asset(
//         //   "assets/background_1.png",
//         // ),
//       ),
//       bottom: PreferredSize(
//           child: AnimatedContainer(
//             //color: MyTheme.textfield_grey,
//             height: _subCategoryList.isEmpty ? 0 : 60,
//             duration: Duration(milliseconds: 500),
//             child: !_isInitial ? buildSubCategory() : buildSubCategory(),
//           ),
//           preferredSize: Size.fromHeight(0.0)),
//       /*leading: Builder(
//         builder: (context) => IconButton(
//           icon: Icon(CupertinoIcons.arrow_left, color: MyTheme.dark_grey),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),*/
//       title: buildAppBarTitle(context),
//       elevation: 0.0,
//       titleSpacing: 0,
//       /*actions: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
//           child: IconButton(
//             icon: Icon(Icons.search, color: MyTheme.dark_grey),
//             onPressed: () {
//               _searchKey = _searchController.text.toString();
//               reset();
//               fetchData();
//             },
//           ),
//         ),
//       ],*/
//     );
//   }

//   Widget buildAppBarTitle(BuildContext context) {
//     return AnimatedCrossFade(
//         firstChild: buildAppBarTitleOption(context),
//         secondChild: buildAppBarSearchOption(context),
//         firstCurve: Curves.fastOutSlowIn,
//         secondCurve: Curves.fastOutSlowIn,
//         crossFadeState: _showSearchBar
//             ? CrossFadeState.showSecond
//             : CrossFadeState.showFirst,
//         duration: Duration(milliseconds: 500));
//   }

//   Container buildAppBarTitleOption(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 18),
//       child: Row(
//         children: [
//           Container(
//             width: 20,
//             child: UsefulElements.backButton(context, color: "white"),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 10),
//             width: DeviceInfo(context).width! / 2,
//             child: Text(
//               categoryInfo?.name ?? "",
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Spacer(),
//           SizedBox(
//             width: 20,
//             child: IconButton(
//                 onPressed: () {
//                   _showSearchBar = true;
//                   setState(() {});
//                 },
//                 padding: EdgeInsets.zero,
//                 icon: Icon(
//                   Icons.search,
//                   size: 25,
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   Container buildAppBarSearchOption(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 18),
//       width: DeviceInfo(context).width,
//       height: 40,
//       child: TextField(
//         controller: _searchController,
//         onTap: () {},
//         onChanged: (txt) {
//           _searchKey = txt;
//           reset();
//           fetchData();
//         },
//         onSubmitted: (txt) {
//           _searchKey = txt;
//           reset();
//           fetchData();
//         },
//         autofocus: false,
//         decoration: InputDecoration(
//           suffixIcon: IconButton(
//             onPressed: () {
//               _showSearchBar = false;
//               setState(() {});
//             },
//             icon: Icon(
//               Icons.clear,
//               color: MyTheme.grey_153,
//             ),
//           ),
//           filled: true,
//           fillColor: MyTheme.white.withOpacity(0.6),
//           hintText: "${AppLocalizations.of(context)!.search_products_from} : " +
//               "" //widget.category_name!
//           ,
//           hintStyle: TextStyle(fontSize: 14.0, color: MyTheme.font_grey),
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: MyTheme.noColor, width: 0.0),
//               borderRadius: BorderRadius.circular(6)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: MyTheme.noColor, width: 0.0),
//               borderRadius: BorderRadius.circular(6)),
//           contentPadding: EdgeInsets.all(8.0),
//         ),
//       ),
//     );
//   }

//   ListView buildSubCategory() {
//     return ListView.separated(
//         padding: EdgeInsets.only(left: 18, right: 18, bottom: 10),
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return CategoryProducts(
//                       slug: _subCategoryList[index].slug!,
//                     );
//                   },
//                 ),
//               );
//             },
//             child: Container(
//               height: _subCategoryList.isEmpty ? 0 : 46,
//               width: _subCategoryList.isEmpty ? 0 : 96,
//               alignment: Alignment.center,
//               padding: EdgeInsets.symmetric(horizontal: 12),
//               decoration:
//                   // BoxDecorations.buildBoxDecoration_1(),
//                   BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10)),
//               child: Text(
//                 _subCategoryList[index].name!,
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                     color: MyTheme.font_grey),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (context, index) {
//           return SizedBox(
//             width: 10,
//           );
//         },
//         itemCount: _subCategoryList.length);
//   }

//   buildProductList() {
//     if (_isInitial && _productList.length == 0) {
//       return SingleChildScrollView(
//         child: ShimmerHelper().buildProductGridShimmer(
//           scontroller: _scrollController,
//         ),
//       );
//     } else if (_productList.length > 0) {
//       return RefreshIndicator(
//         color: MyTheme.accent_color,
//         backgroundColor: Colors.white,
//         displacement: 0,
//         onRefresh: _onRefresh,
//         child: SingleChildScrollView(
//           controller: _xcrollController,
//           physics: const BouncingScrollPhysics(
//               parent: AlwaysScrollableScrollPhysics()),
//           child: MasonryGridView.count(
//             crossAxisCount: 2,
//             mainAxisSpacing: 14,
//             crossAxisSpacing: 14,
//             itemCount: _productList.length,
//             shrinkWrap: true,
//             padding:
//                 EdgeInsets.only(top: 10.0, bottom: 10, left: 18, right: 18),
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               // 3
//               return ProductCard(
//                   id: _productList[index].id,
//                   slug: _productList[index].slug,
//                   image: _productList[index].thumbnail_image,
//                   name: _productList[index].name,
//                   main_price: _productList[index].main_price,
//                   stroked_price: _productList[index].stroked_price,
//                   discount: _productList[index].discount,
//                   is_wholesale: _productList[index].isWholesale,
//                   has_discount: _productList[index].has_discount);
//             },
//           ),
//         ),
//       );
//     } else if (_totalData == 0) {
//       return Center(
//           child: Text(AppLocalizations.of(context)!.no_data_is_available));
//     } else {
//       return Container(); // should never be happening
//     }
//   }
// }
import 'package:MetaBit/custom/device_info.dart';
import 'package:MetaBit/custom/useful_elements.dart';
import 'package:MetaBit/data_model/category_response.dart';
import 'package:MetaBit/dummy_data/products.dart';
import 'package:MetaBit/helpers/shimmer_helper.dart';
import 'package:MetaBit/my_theme.dart';
import 'package:MetaBit/repositories/category_repository.dart';
import 'package:MetaBit/repositories/product_repository.dart';
import 'package:MetaBit/ui_elements/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryProducts extends StatefulWidget {
  CategoryProducts({Key? key, required this.slug,required this.id}) : super(key: key);
  final String slug;
  final int id;

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  ScrollController _scrollController = ScrollController();
  ScrollController _xcrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  int _page = 1;
  int? _totalData = 0;
  bool _isInitial = true;
  String _searchKey = "";
  Category? categoryInfo;
  bool _showSearchBar = false;
  List<dynamic> _productList = [];
  bool _showLoadingContainer = false;
  List<Category> _subCategoryList = [];

  // getSubCategory() async {
  //   var res = await CategoryRepository().getCategories(parent_id: widget.slug);
  //   _subCategoryList.addAll(res.categories!);
  //   setState(() {});
  // }
  getSubCategory() async {
    var res = await CategoryRepository().getCategories(parent_id: widget.id);
    if (res.categories != null) {
      _subCategoryList.addAll(res.categories!);
    }
    setState(() {});
  }

  getCategoryInfo() async {
    var res = await CategoryRepository().getCategoryInfo(widget.slug);
    if (res.categories?.isNotEmpty ?? false) {
      categoryInfo = res.categories?.first ?? null;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCategoryInfo();
    fetchAllDate();

    _xcrollController.addListener(() {
      if (_xcrollController.position.pixels ==
          _xcrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _showLoadingContainer = true;
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _xcrollController.dispose();
    super.dispose();
  }

  fetchData() async {
    var productResponse = await ProductRepository()
        .getCategoryProducts(id: widget.slug, page: _page, name: _searchKey);
    _productList.addAll(productResponse.products!);
    _isInitial = false;
    _totalData = productList.length;
    _showLoadingContainer = false;
    setState(() {});
  }

  fetchAllDate() {
    fetchData();
    getSubCategory();
  }

  reset() {
    _subCategoryList.clear();
    _productList.clear();
    _isInitial = true;
    _totalData = 0;
    _page = 1;
    _showLoadingContainer = false;
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAllDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.mainColor,
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          buildProductList(),
          Align(
              alignment: Alignment.bottomCenter, child: buildLoadingContainer())
        ],
      ),
    );
  }

  Container buildLoadingContainer() {
    return Container(
      height: _showLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalData == _productList.length
            ? AppLocalizations.of(context)!.no_more_products_ucf
            : AppLocalizations.of(context)!.loading_more_products_ucf),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: _subCategoryList.isEmpty
          ? DeviceInfo(context).height! / 10
          : DeviceInfo(context).height! / 6.5,
      flexibleSpace: Container(
        height: DeviceInfo(context).height! / 4,
        width: DeviceInfo(context).width,
        color: Color(0xffF2F1F6),
        alignment: Alignment.topRight,
        // child: Image.asset(
        //   "assets/background_1.png",
        // ),
      ),
      bottom: PreferredSize(
          child: AnimatedContainer(
            //color: MyTheme.textfield_grey,
            color: MyTheme.mainColor,
            height: _subCategoryList.isEmpty ? 0 : 40,
            duration: Duration(milliseconds: 500),
            child: !_isInitial ? buildSubCategory() : buildSubCategory(),
          ),
          preferredSize: Size.fromHeight(-35)),
      /*leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(CupertinoIcons.arrow_left, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),*/
      title: buildAppBarTitle(context),
      elevation: 0.0,
      titleSpacing: 0,
      /*actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.search, color: MyTheme.dark_grey),
            onPressed: () {
              _searchKey = _searchController.text.toString();
              reset();
              fetchData();
            },
          ),
        ),
      ],*/
    );
  }

  Widget buildAppBarTitle(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: buildAppBarTitleOption(context),
        secondChild: buildAppBarSearchOption(context),
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn,
        crossFadeState: _showSearchBar
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 500));
  }

  Container buildAppBarTitleOption(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 37),
      child: Row(
        children: [
          Container(
            width: 20,
            child: UsefulElements.backButton(context, color: "black"),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: DeviceInfo(context).width! / 2,
            child: Text(
              categoryInfo?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          SizedBox(
              width: 20,
              child:
                  //  IconButton(
                  //     onPressed: () {
                  //       _showSearchBar = true;
                  //       setState(() {});
                  //     },
                  //     padding: EdgeInsets.zero,
                  //     icon: Icon(
                  //       Icons.search,
                  //       size: 25,
                  //     )),
                  GestureDetector(
                      onTap: () {
                        _showSearchBar = true;
                        setState(() {});
                      },
                      child: Image.asset('assets/search.png')))
        ],
      ),
    );
  }

  Container buildAppBarSearchOption(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      width: DeviceInfo(context).width,
      height: 40,
      child: TextField(
        controller: _searchController,
        onTap: () {},
        onChanged: (txt) {
          _searchKey = txt;
          reset();
          fetchData();
        },
        onSubmitted: (txt) {
          _searchKey = txt;
          reset();
          fetchData();
        },
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              _showSearchBar = false;
              setState(() {});
            },
            icon: Icon(
              Icons.clear,
              color: MyTheme.grey_153,
            ),
          ),
          filled: true,
          fillColor: MyTheme.white.withOpacity(0.6),
          hintText: "${AppLocalizations.of(context)!.search_products_from} : " +
              "" //widget.category_name!
          ,
          hintStyle: TextStyle(fontSize: 14.0, color: MyTheme.font_grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.noColor, width: 0.0),
              borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.noColor, width: 0.0),
              borderRadius: BorderRadius.circular(6)),
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }

  // ListView buildSubCategory() {
  //   return ListView.separated(
  //       padding: EdgeInsets.only(left: 18, right: 18, bottom: 10),
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, index) {
  //         return InkWell(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) {
  //                   return CategoryProducts(
  //                     slug: _subCategoryList[index].slug!,
  //                   );
  //                 },
  //               ),
  //             );
  //           },
  //           child: Container(
  //             height: _subCategoryList.isEmpty ? 0 : 46,
  //             width: _subCategoryList.isEmpty ? 0 : 96,
  //             alignment: Alignment.center,
  //             padding: EdgeInsets.symmetric(horizontal: 12),
  //             decoration:
  //                 // BoxDecorations.buildBoxDecoration_1(),
  //                 BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(10)),
  //             child: Text(
  //               _subCategoryList[index].name!,
  //               style: TextStyle(
  //                   fontSize: 10,
  //                   fontWeight: FontWeight.bold,
  //                   color: MyTheme.font_grey),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //         );
  //       },
  //       separatorBuilder: (context, index) {
  //         return SizedBox(
  //           width: 10,
  //         );
  //       },
  //       itemCount: _subCategoryList.length);
  // }
  ListView buildSubCategory() {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true, // Ensures ListView takes only the space needed
      itemBuilder: (context, index) {
        // Determine the color for the container
        Color containerColor;
        if (index == 0) {
          containerColor = Color(0xffE52C04); // First container
        } else if (index == 1) {
          containerColor = Color(0xffF5931B); // Second container
        } else {
          containerColor = Color(0xffE9EAEB); // Other containers
        }

        // Determine the text color based on the index
        Color textColor;
        if (index == 0 || index == 1) {
          textColor = Colors.white; // First and second container text color
        } else {
          textColor =
              MyTheme.font_grey; // Default text color for other containers
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CategoryProducts(
                    slug: _subCategoryList[index].slug!,
                    id: _subCategoryList[index].id!,
                  );
                },
              ),
            );
          },
          child: Container(
            height: _subCategoryList.isEmpty ? 0 : 30, // Decrease height here
            width: _subCategoryList.isEmpty ? 0 : 99,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: containerColor, // Set the dynamic container color here
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _subCategoryList[index].name!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: textColor, // Set the dynamic text color here
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 10,
        );
      },
      itemCount: _subCategoryList.length,
    );
  }

  buildProductList() {
    if (_isInitial && _productList.length == 0) {
      return SingleChildScrollView(
        child: ShimmerHelper().buildProductGridShimmer(
          scontroller: _scrollController,
        ),
      );
    } else if (_productList.length > 0) {
      return RefreshIndicator(
        color: MyTheme.accent_color,
        backgroundColor: Colors.white,
        displacement: 0,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          controller: _xcrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            itemCount: _productList.length,
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: 10.0, bottom: 10, left: 18, right: 18),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // 3
              return ProductCard(
                  id: _productList[index].id,
                  slug: _productList[index].slug,
                  image: _productList[index].thumbnail_image,
                  name: _productList[index].name,
                  main_price: _productList[index].main_price,
                  stroked_price: _productList[index].stroked_price,
                  discount: _productList[index].discount,
                  is_wholesale: _productList[index].isWholesale,
                  has_discount: _productList[index].has_discount);
            },
          ),
        ),
      );
    } else if (_productList.isEmpty) {
      return Center(
          child: Text(AppLocalizations.of(context)!.no_data_is_available));
    } else {
      return Container(); // should never be happening
    }
  }
}
