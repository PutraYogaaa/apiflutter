class Blog {
  final String name;
  final String id;
  final String gender;

  const Blog({
    required this.name,
    required this.id,
    required this.gender,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      name: json['name'],
      id: json['id'],
      gender: json['gender'],
    );
  }
}
