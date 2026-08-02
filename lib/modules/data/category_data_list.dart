import 'package:event_app/modules/data/category_data.dart';
import '../../core/config/gen/assets.gen.dart';

class CategoryDataList {
  static final List<CategoryData> categories = [
    CategoryData(
      categoryID: "",
      eventID: "all",
      name: "All",
      icn: Assets.icons.allBlue.path,
    ),
    CategoryData(
      categoryID: "",
      eventID: "sport",
      name: "Sport",
      img: Assets.images.sport.path,
      icn: Assets.icons.bike.path,
    ),
    CategoryData(
      categoryID: "",
      eventID: "birthday",
      name: "Birthday",
      img: Assets.images.birthday.path,
      icn: Assets.icons.birthdayCake.path,
    ),
    CategoryData(
      categoryID: "",
      eventID: "bookclub",
      name: "Book Club",
      img: Assets.images.bookClub.path,
      icn: Assets.icons.book.path,
    ),
    CategoryData(
      categoryID: "",
      eventID: "exhibition",
      name: "Exhibition",
      img: Assets.images.exhibition.path,
      icn: Assets.icons.birthdayCake.path,
    ),
  ];

  CategoryData getCategoryDataByID(String id) {
    return categories.firstWhere(
          (category) => category.categoryID == id,
      orElse: () => categories.first,
    );
  }
}