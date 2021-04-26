import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Categoriesfirst extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categoriesfirst> {
  List<String> categories = [
    "Tất cả",
    "Quạt",
    "Nhẫn",
    "Đèn",
    "Lọ thủy tinh",
    "Phụ kiện"
  ];
  // By default first one is selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1),
      child: SizedBox(
        height: SizeConfig.defaultSize * 3.5, // 35
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategoriItem(index),
        ),
      ),
    );
  }

  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize * 1),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 1.5, //20
          vertical: SizeConfig.defaultSize * 0.5, //5
        ),
        decoration: BoxDecoration(
            color:
                selectedIndex == index ? Color(0xFFEFF3EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 1.6, // 16
            )),
        child: Text(
          categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? kPrimaryColor : Color(0xFFC2C2B5),
          ),
        ),
      ),
    );
  }
}
