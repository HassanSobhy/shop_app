class Category {
  int id;
  String image;
  String name;

  Category({
    this.id,
    this.image,
    this.name,
  });

  //Convert from JSON To Category Model
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}
