import 'package:catalift_assignment/constants/app_lists.dart';
import 'package:catalift_assignment/model/course_model.dart';
import 'package:flutter/cupertino.dart';

class ProductCategoryController extends ChangeNotifier {
  int _selectedIndex = 0;
  List<Course> _courseList = [];
  bool _isExpanded = false;
  List<Course> _cartList = [];

  int get selectedIndex => _selectedIndex;
  List<Course> get courseList => _courseList;
  bool get isExpanded => _isExpanded;
  List<Course> get cartList => _cartList;

  void changeCategory({required int index}) {
    _selectedIndex = index;
    print("SELECTED CATEGORY :::: ${_selectedIndex}");
    notifyListeners();
  }

  void getProductsList({required String name}) {
    if (name == "All") {
      _courseList = AppLists.courseList;
      _courseList.shuffle();
    } else {
      _courseList =
          AppLists.courseList
              .where((element) => element.category == name)
              .toList();
    }

    if (_courseList.isNotEmpty) {
      print("LIST HAS DATA");
    } else {
      print("LIST HAS NO DATA");
    }
    notifyListeners();
  }

  void changeExpandedView() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  void addToCartItem({required Course course}) {
    _cartList.add(course);
    notifyListeners();
  }
}
