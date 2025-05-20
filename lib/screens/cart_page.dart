import 'package:catalift_assignment/constants/app_colors.dart';
import 'package:catalift_assignment/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../provider/product_category_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.blueColor),
        title: Text(AppStrings.cart, style: TextStyle(color: Colors.white)),
      ),
      body: _buildCartPage(),
    );
  }

  Widget _buildCartPage() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCartHeading(),
          _buildCartItemsList(),
          _buildRelatedCourseHeadingRow(),
          _buildRelatedProductGridView(),
        ],
      ),
    );
  }

  Widget _buildCartItemsList() {
    return Consumer<ProductCategoryController>(
      builder: (context, value, child) {
        if (value.cartList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                "No Course In Cart",
                style: TextStyle(
                  color: HexColor(AppColors.blueColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          );
        }
        return Container(
          height: value.cartList.length * height * 0.170,
          child: ListView.builder(
            padding: EdgeInsets.only(top: height * 0.005),
            physics: NeverScrollableScrollPhysics(),
            itemCount: value.cartList.length,
            itemBuilder: (context, index) {
              print("LIST BUILD");
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.040),
                  height: height * 0.160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                    color: HexColor("#F2F2F2"),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width * 0.020),
                        height: height * 0.130,
                        width: width * 0.260,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            "https://imgs.search.brave.com/iWekQnDcrDpsYG2gmFCBwV6dEJi--Ufld5lNnWN-qpk/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9waXhs/ci5jb20vaW1hZ2Vz/L2luZGV4L2FpLWlt/YWdlLWdlbmVyYXRv/ci10d28ud2VicA",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.025,
                          left: width * 0.030,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.400,
                              // color: Colors.red,
                              child: Text(
                                value.cartList[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height * 0.010),
                              width: width * 0.400,
                              // color: Colors.red,
                              child: Text(
                                "${value.cartList[index].lessons} lessons",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.010),
                            Row(
                              children: [
                                Text(
                                  "MRP.",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.320,
                                  // color: Colors.red,
                                  child: Text(
                                    "₹${value.cartList[index].price}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.010),
                          ],
                        ),
                      ),
                      SizedBox(width: width * 0.170),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.010),
                        child: Column(
                          children: [SizedBox(height: height * 0.005)],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCartHeading() {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.020, left: width * 0.070),
      child: Text(
        AppStrings.cart,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildRelatedCourseHeadingRow() {
    return Row(
      children: [
        SizedBox(width: width * 0.050),
        Text(
          AppStrings.similarCourses,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(width: width * 0.370),
        Consumer<ProductCategoryController>(
          builder: (context, value, child) {
            return InkWell(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                value.changeExpandedView();
              },
              child: Text(
                value.isExpanded ? AppStrings.seeLess : AppStrings.seeAll,
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRelatedProductGridView() {
    return Consumer<ProductCategoryController>(
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets.only(top: height * 0.020, left: width * 0.030),
          height: value.isExpanded ? height * 0.630 : height * 0.310,
          width: double.infinity,
          // color: Colors.red,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: value.courseList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 2.2,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return _buildGridViewItem(index: index, value: value);
            },
          ),
        );
      },
    );
  }

  Widget _buildGridViewItem({
    required int index,
    required ProductCategoryController value,
  }) {
    return Container(
      height: height * 0.310,
      width: width * 0.350,
      decoration: BoxDecoration(
        // color: Colors.blue,
        // border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Container(
            height: height * 0.135,
            width: width * 0.280,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Container(
                  height: height * 0.135,
                  width: width * 0.280,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://imgs.search.brave.com/ilKBczmU2gW4yTpWSxA2fofJnSDFeSySHVirzfwFs9Q/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA0LzY3LzAyLzk2/LzM2MF9GXzQ2NzAy/OTY1MF94TWxxMnl6/Ym5Rc1pPRmthdVdS/U1AxTVREeW5EV0FV/ci5qcGc",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: width * 0.200,
                  top: height * 0.010,
                  child: Container(
                    height: height * 0.025,
                    width: width * 0.050,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Icon(
                      Icons.bookmark_border,
                      color: Colors.teal,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.010),
          Row(
            children: [
              SizedBox(width: width * 0.020),
              Container(
                height: height * 0.020,
                width: width * 0.040,
                child: Image.asset("assets/images/output-onlinepngtools.png"),
              ),
              SizedBox(width: width * 0.020),
              Text(
                "${value.courseList[index].lessons} lessons",
                style: TextStyle(
                  color: Color.fromRGBO(120, 205, 150, 100),
                  fontWeight: FontWeight.normal,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          Container(
            // alignment: Alignment.center,
            margin: EdgeInsets.only(top: height * 0.005),
            height: height * 0.040,
            width: width * 0.290,
            // color: Colors.red,
            child: Text(
              textAlign: TextAlign.start, // or center if it feels better
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              value.courseList[index].name,
              style: TextStyle(
                color: HexColor(AppColors.blueColor),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: height * 0.025,
            width: width * 0.290,
            // color: Colors.red,
            child: Text(
              "₹${value.courseList[index].price}",
              style: TextStyle(
                color: HexColor(AppColors.darkGreenColor),
                fontSize: 18,
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: height * 0.010),
            height: height * 0.040,
            width: width * 0.30,

            decoration: BoxDecoration(
              color: HexColor(AppColors.blueColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              AppStrings.view,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
