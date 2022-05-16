
import '../Utilities/Config.dart';

class Category
{
  final String id;
  final String title;
  final String slug;
  final String parent;
  final String leval;
  final String description;
  final String image;
  final String status;
  final String Count;
  final String PCount;

  const Category(
      {
        required this.id,
        required this.title,
        required this.slug,
        required this.parent,
        required this.leval,
        required this.description,
        required this.image,
        required this.status,
        required this.Count,
        required this.PCount
      });

  factory Category.fromJson(Map<String, dynamic> json)
  {
    return Category(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      parent: json["parent"],
      leval: json["leval"],
      description: json["description"],
      image: Config.CATEGORY_IMAGE  + json["image"],
      status: json["status"],
      Count: json["Count"],
      PCount: json["PCount"],
    );
  }
}
