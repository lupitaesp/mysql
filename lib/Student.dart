class Student {
  String id;
  String firstName;
  String lastName1;
  String lastName2;
  String email;
  String phone;
  String matricula;

  Student({this.id, this.firstName, this.lastName1, this.lastName2, this.email, this.phone, this.matricula});

  //Patrones de diseño, ventajas de regresar un objeto
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName1: json['last_name1'] as String,
      lastName2: json['last_name2'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      matricula: json['matricula'] as String,
    );
  }
}