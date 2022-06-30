class GetUserBody {
  final int id;

  GetUserBody({
    required this.id,
  });

  Map<String, dynamic> toDB() {
    return {'id': id};
  }
}
