class Questionaire {
  Questionaire({required this.id, required this.question});
  int id;
  String question;


 factory Questionaire.fromJson(Map<String, dynamic> json) {
    return Questionaire(
      id: json['id'] as int,
      question: json['title'] as String,
    );
  }

}
