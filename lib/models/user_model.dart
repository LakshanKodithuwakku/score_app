class User {
  final String name;
  final int age;
  final String gender;
  final int ac1_marks;
  final int ac2_marks;
  final int ac1_clicked_time;
  final int ac2_clicked_time;

  User({
    required this.name,
    required this.age,
    required this.gender,
    required this.ac1_marks,
    required this.ac2_marks,
    required this.ac1_clicked_time,
    required this.ac2_clicked_time,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'gender': gender,
    'Activity 1 marks': ac1_marks,
    'Activity 2 marks': ac2_marks,
    'Activity 1 clicked second' : ac1_clicked_time,
    'Activity 2 clicked second' : ac2_clicked_time,
  };
}
