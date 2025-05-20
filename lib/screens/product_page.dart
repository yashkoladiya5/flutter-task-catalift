import 'package:catalift_assignment/constants/app_colors.dart';
import 'package:catalift_assignment/constants/app_lists.dart';
import 'package:catalift_assignment/constants/app_strings.dart';
import 'package:catalift_assignment/screens/cart_page.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../provider/product_category_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late double height;
  late double width;

  double getTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width + 30;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductCategoryController>(
        context,
        listen: false,
      ).getProductsList(name: "All");
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor("#fafbfb"),

      body: _buildProductPage(),
    );
  }

  Widget _buildProductPage() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderImageContainerView(),
          _buildGoToCartButtonRow(),
          SizedBox(height: height * 0.020),
          _buildNameAndPriceContainerView(),
          _buildDescriptionView(),
          SizedBox(height: height * 0.010),
          _buildBuyNowButtonRowView(),
          SizedBox(height: height * 0.030),
          _buildSimilarCourseHeading(),
          _buildCategorySelectListView(),
          _buildRelatedCourseGridView(),
        ],
      ),
    );
  }

  Widget _buildHeaderImageContainerView() {
    return Container(
      height: height * 0.460,
      width: double.infinity,
      // color: Colors.red,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Container(
            // color: Colors.blue,
            height: height * 0.460,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: Image.network(
                "https://imgs.search.brave.com/TOZgg8nfZIVJjhU1vjOBbmKB9S_PoMZzI5fEFOf-jek/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTE1/MzQyOTQzMS9waG90/by9sZWFybmluZy1h/bmQtZGV2ZWxvcG1l/bnQuanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPTNPeWJwSm9v/bVpKZW13WUNoTDlh/ZmVHZ2pRNjdpWU54/clNGbTFmY2pabjQ9",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: height * 0.070,
            child: Row(
              children: [
                SizedBox(width: width * 0.050),
                Container(
                  height: height * 0.050,
                  width: width * 0.110,
                  decoration: BoxDecoration(
                    color: HexColor(AppColors.blueColor),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.030),
                Text(
                  AppStrings.courseDetails,
                  style: TextStyle(
                    color: HexColor(AppColors.blueColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(width: width * 0.330),
                Icon(Icons.bookmark_border, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoToCartButtonRow() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: width * 0.050, top: height * 0.020),
          alignment: Alignment.center,
          height: height * 0.040,
          width: width * 0.300,
          decoration: BoxDecoration(
            color: HexColor(AppColors.greenColor),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            AppStrings.highlyEnrolled,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: width * 0.250),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) {
                  return CartPage();
                },
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: width * 0.050, top: height * 0.020),
            alignment: Alignment.center,
            height: height * 0.040,
            width: width * 0.300,
            decoration: BoxDecoration(
              color: HexColor(AppColors.blueColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              AppStrings.goToCart,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndPriceContainerView() {
    return Container(
      margin: EdgeInsets.only(left: width * 0.050),
      height: height * 0.080,
      width: double.infinity,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppStrings.artificialIntelligence,
                style: TextStyle(
                  color: HexColor(AppColors.blueColor),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    color: Colors.orange,
                    size: 20,
                  ),
                  Text("4.5", style: TextStyle(color: Colors.grey)),
                  Text(
                    "  |  ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text("8,374 enrolled", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          SizedBox(width: width * 0.220),
          Text(
            "₹1500",
            style: TextStyle(
              color: HexColor(AppColors.darkGreenColor),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionView() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.050,
        vertical: height * 0.010,
      ),
      height: height * 0.120,
      width: double.infinity,
      // color: Colors.red,
      child: Text(
        AppStrings.productDescription,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBuyNowButtonRowView() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Provider.of<ProductCategoryController>(
                context,
                listen: false,
              ).addToCartItem(course: AppLists.courseList[0]);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Course Added To Cart")));
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                right: width * 0.010,
                left: width * 0.050,
              ),
              height: height * 0.050,
              decoration: BoxDecoration(
                color: HexColor(AppColors.purpleColor),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: HexColor(AppColors.blueColor),
                  width: 2,
                ),
              ),
              child: Text(
                AppStrings.addToCart,
                style: TextStyle(
                  color: HexColor(AppColors.blueColor),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: width * 0.025, left: width * 0.040),
            height: height * 0.050,
            decoration: BoxDecoration(
              color: HexColor(AppColors.blueColor),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              AppStrings.buyNow,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarCourseHeading() {
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

  Widget _buildCategorySelectListView() {
    return Container(
      margin: EdgeInsets.only(left: width * 0.050, top: height * 0.010),
      height: height * 0.050,
      width: double.infinity,
      // color: Colors.red,
      child: Consumer<ProductCategoryController>(
        builder: (context, value, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppLists.courseOptionList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.007,
                  horizontal: width * 0.010,
                ),
                child: InkWell(
                  onTap: () {
                    value.changeCategory(index: index);
                    value.getProductsList(
                      name: AppLists.courseOptionList[index],
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.030,
                    width: getTextWidth(
                      AppLists.courseOptionList[index],
                      TextStyle(fontSize: 16),
                    ),
                    decoration: BoxDecoration(
                      color: HexColor(
                        value.selectedIndex == index
                            ? AppColors.blueColor
                            : AppColors.purpleColor,
                      ),
                      border: Border.all(
                        color: HexColor(AppColors.blueColor),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      AppLists.courseOptionList[index],
                      style: TextStyle(
                        color:
                            value.selectedIndex == index
                                ? Colors.white
                                : HexColor(AppColors.blueColor),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRelatedCourseGridView() {
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
              return _buildGridViewItem(value: value, index: index);
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

          InkWell(
            onTap: () {
              value.addToCartItem(course: value.courseList[index]);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Course Added To Cart")));
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: height * 0.010),
              height: height * 0.040,
              width: width * 0.30,

              decoration: BoxDecoration(
                color: HexColor(AppColors.blueColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                AppStrings.add,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
