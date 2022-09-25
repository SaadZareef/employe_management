class Employee {
  final String id;
  final String name;
  final String profession;
  final String salary;
  final String gender;
  final String image;
  Employee(
      {this.id = '',
      required this.image,
      required this.name,
      required this.profession,
      required this.salary,
      required this.gender});

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'profession': profession,
        'salary': salary,
        'gender': gender,
      };

  static Employee fromJson(Map<String, dynamic> json) => Employee(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        profession: json['profession'],
        salary: json['salary'],
        gender: json['gender'],
      );
}
