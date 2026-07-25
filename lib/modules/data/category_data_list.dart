import 'package:event_app/modules/data/category_data.dart';

import '../../core/config/gen/assets.gen.dart';

class CategoryDataList {
  static final categories = [
    CategoryData(
      id: "sport",
      name: "Sport",
      img: Assets.images.sport.path,
      icn: Assets.icons.bike.path,
    ),
    CategoryData(
      id: "birthday",
      name: "Birthday",
      img: Assets.images.birthday.path,
      icn: Assets.icons.birthdayCake.path,
    ),
    CategoryData(
      id: "bookclub",
      name: "Book Club",
      img: Assets.images.bookClub.path,
      icn: Assets.icons.book.path,
    ),
    CategoryData(
      id: "exhibition",
      name: "Exhibition",
      img: Assets.images.exhibition.path,
      icn: Assets.icons.exhibitionGalleryIcon.path,
    ),
  ];
}
