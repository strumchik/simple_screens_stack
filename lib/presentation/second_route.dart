import 'package:flutter/material.dart';
import 'package:simple_screens_stack/domain/model/user.dart';
import 'package:simple_screens_stack/domain/repository/user_data_repository.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  Future<List<User>> _fetchUsers() async {
    return UserDataRepository().getUsers();
    // return DBDriver().oldUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Message'),
      ),
      body: FutureBuilder<List<User>>(
            future: _fetchUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: snapshot.data!.map((e) => listElement(e.name,
                      e.surname, e.email, e.getGenderName(),
                      e.getBirthdateAsText())).toList(),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            }),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.keyboard_arrow_left),
      ),
    );
  }

  Container listElement(String name, String surname, String email,
      String gender, String birthdate) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1)),
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(surname),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(email),
            ),
          ],),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(gender),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(birthdate),
              ),
            ],
          )
        ],
      ),
    );
  }

}